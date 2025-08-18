//
//  CartViewModel.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 16/08/25.
//

import SwiftUI
import SwiftData

struct CartView: View {
    @Environment(\.modelContext) private var context
    @State private var viewModel: CartViewModel?

    var body: some View {
        NavigationStack {
            if let viewModel = viewModel {
                if viewModel.isLoading {
                    ProgressView()
                        .navigationTitle("Cart")
                } else if viewModel.cartProducts.isEmpty {
                    EmptyStateCart()
                        .navigationTitle("Cart")
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.cartProducts) { item in
                                ProductListAsyncImage(
                                    thumbnailURL: item.thumbnail,
                                    productName: item.product.name,
                                    price: item.product.price,
                                    quantity: Binding(
                                        get: { item.product.quantity },
                                        set: { newValue in
                                            if newValue > item.product.quantity {
                                                viewModel.increaseQuantity(item.product)
                                            } else {
                                                viewModel.decreaseQuantity(item.product)
                                            }
                                        }
                                    ),
                                    variant: .stepper
                                )
                            }
                        }
                        .padding()
                        VStack {
                            Divider()
                            HStack {
                                Text("Total")
                                    .font(.headline)
                                Spacer()
                                Text("US$ \(viewModel.totalPrice(), specifier: "%.2f")")
                                    .bold()
                            }
                            .padding(.top, 16)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }

                    VStack {
                        Button("Checkout") {
                            //action botar aqui
                            //print("Ir para pagamento")
                        }
                        .foregroundStyle(.labelsPrimary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(.fillsTertiary)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                    }
                    .navigationTitle("Cart")
                }
                
            } else {
                ProgressView()
                .navigationTitle("Cart")
            }
            
        }
        .task {
            let vm = CartViewModel(context: context)
            await vm.loadCart()
            viewModel = vm
        }
    }
}
