//
//  CartVM.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 16/08/25.
//

import SwiftUI
import SwiftData

struct CartView: View {
    @StateObject private var vm: CartVM
    @State private var showingCheckoutAlert = false
    @Environment(\.dismiss) private var dismiss

    init(vm: CartVM) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    // Função para criar cada linha do produto
    private func cartProductRow(for item: CartProductDisplay) -> some View {
        let productName = item.dto?.title ?? "Nulo"
        let price = item.dto?.price ?? 0.00
        let thumbnail = item.dto?.thumbnail
        
        return ProductListAsyncImage(
            image: thumbnail,
            productName: productName,
            price: price,
            quantity: Binding(
                get: { item.product.quantity },
                set: { _ in } // Binding vazio já que usamos stepper
            ),
            variant: .stepper(
                onIncrement: {
                    vm.increaseQuantity(item.product)
                },
                onDecrement: {
                    vm.decreaseQuantity(item.product)
                }
            )
        )
    }
    
    // Seção de checkout extraída
    private var checkoutSection: some View {
        VStack {
            Divider()
            HStack {
                Text("Total")
                    .font(.headline)
                Spacer()
                Text(totalPriceText)
                    .bold()
            }
            .padding(.top, 16)
            .padding(.horizontal)
            
            Button("Checkout") {
                showingCheckoutAlert = true
            }
            .foregroundStyle(.labelsPrimary)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(.fillsTertiary)
            .cornerRadius(12)
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
    }
    
    private var totalPriceText: String {
        "US$ \(vm.totalPrice())"
    }
    
    // Conteúdo principal da view
    private var contentView: some View {
        Group {
            if vm.isLoading {
                ProgressView()
                    .navigationTitle("Cart")
            } else if vm.cartProducts.isEmpty {
                EmptyStateCart()
                    .navigationTitle("Cart")
            } else {
                VStack {
                    // Lista de produtos
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(vm.cartProducts) { item in
                                cartProductRow(for: item) // ← Agora simplificado!
                            }
                        }
                        .padding()
                    }
                    
                    checkoutSection
                }
                .navigationTitle("Cart")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            contentView
        }
        .alert("Confirmar Checkout", isPresented: $showingCheckoutAlert) {
            Button("Cancelar", role: .cancel) { }
            Button("Confirmar") {
                Task {
                    await vm.checkout()
                }
            }
        } message: {
            Text("Finalizar compra de \(vm.cartProducts.count) itens por \(totalPriceText)?")
        }
        .alert("Compra Finalizada", isPresented: $vm.checkoutSuccess) {
            Button("OK") { dismiss() }
        } message: {
            Text("Seu pedido foi realizado com sucesso!")
        }
        .task {
            await vm.loadCart()
        }
        .refreshable {
            await vm.loadCart()
        }
    }
}
