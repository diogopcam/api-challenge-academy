//
//  CartViewModel.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 16/08/25.
//

import SwiftUI
import SwiftData

struct CartView: View {
    @Query private var items: [CartItem] // <- Agora é reativo
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationStack {
            VStack {
                if items.isEmpty {
                    EmptyStateCart()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(items, id: \.self) { item in
                                ProductList(
                                    image: nil,
                                    productName: item.name,
                                    price: item.price,
                                    quantity: Binding(
                                        get: { item.quantity },
                                        set: { newValue in
                                            item.quantity = newValue
                                            try? context.save()
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
                                Text("R$ \(items.reduce(0) { $0 + ($1.price * Double($1.quantity)) }, specifier: "%.2f")")
                                    .bold()
                            }
                            .padding(.top, 16)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 80)
                    }

                    VStack {
                        Spacer()
                        Button("Checkout") {
                            print("Ir para pagamento")
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(.ultraThinMaterial)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .navigationTitle("Carrinho")
        }
    }
}


struct CartContentView: View {
    @Bindable var viewModel: CartViewModel

    var body: some View {
        if viewModel.items.isEmpty {
            EmptyStateCart()
        } else {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.items, id: \.self) { item in
                        ProductList(
                            image: nil,
                            productName: item.name,
                            price: item.price,
                            quantity: Binding(
                                get: { item.quantity },
                                set: { newValue in
                                    viewModel.updateQuantity(for: item, quantity: newValue)
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
                        Text("R$ \(viewModel.total, specifier: "%.2f")")
                            .bold()
                    }
                    .padding(.top, 16)
                }
                .padding(.horizontal)
                .padding(.bottom, 80)
            }

            VStack {
                Spacer()
                Button("Checkout") {
                    print("Ir para pagamento")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.ultraThinMaterial)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}


