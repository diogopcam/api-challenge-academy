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
                                ProductListAsyncImage(
                                    image: item.dto?.thumbnail, // Use o DTO para a imagem
                                    productName: item.product.name,
                                    price: item.product.price,
                                    quantity: Binding(
                                        get: { item.product.quantity },
                                        set: { newValue in
                                            // Esta lógica precisa ser ajustada
                                            // Melhor usar botões separados
                                        }
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
                        }
                        .padding()
                    }
                    
                    // Total e checkout
                    VStack {
                        Divider()
                        HStack {
                            Text("Total")
                                .font(.headline)
                            Spacer()
                            Text("US$ \(vm.totalPrice(), specifier: "%.2f")")
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
                .navigationTitle("Cart")
            }
        }
        .alert("Confirmar Checkout", isPresented: $showingCheckoutAlert) {
            Button("Cancelar", role: .cancel) { }
            Button("Confirmar") {
                Task {
                    await vm.checkout()
                }
            }
        } message: {
            Text("Finalizar compra de \(vm.cartProducts.count) itens por US$ \(vm.totalPrice(), specifier: "%.2f")?")
        }
        .alert("Compra Finalizada", isPresented: $vm.checkoutSuccess) {
            Button("OK") {
                dismiss()
            }
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
