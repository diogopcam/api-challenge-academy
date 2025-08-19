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
        .task { await vm.loadCart() }
        .refreshable { await vm.loadCart() }
    }
    
    // MARK: - Componentes da View
    
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
                    productsList
                    checkoutSection
                }
                .navigationTitle("Cart")
            }
        }
    }
    
    private var productsList: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(vm.cartProducts) { item in
                    cartProductRow(for: item)
                }
            }
            .padding()
        }
    }
    
    private func cartProductRow(for product: ProductDTO) -> some View {
        let quantity = vm.quantity(for: product.id) // ← Busca do ViewModel
        
        return ProductListAsyncImage(
            thumbnailURL: product.thumbnail,
            productName: product.title,
            price: product.price,
            quantity: Binding(
                get: { quantity },
                set: { _ in } // Não usado
            ),
            variant: .stepper(
                onIncrement: { vm.increaseQuantity(product) },
                onDecrement: { vm.decreaseQuantity(product) }
            )
        )
    }
    
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
            
            checkoutButton
        }
    }
    
    private var checkoutButton: some View {
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
    
    private var totalPriceText: String {
        "US$ \(vm.totalPrice(), specifier: "%.2f")"
    }
}
