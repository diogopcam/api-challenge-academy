//
//  CartViewModel.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 16/08/25.
//



//struct CartView: View {
//    @Query private var items: [CartItem]
//    @Environment(\.modelContext) private var context
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                if items.isEmpty {
//                    EmptyStateCart()
//                } else {
//                    ScrollView {
//                        VStack(spacing: 16) {
//                            ForEach(items, id: \.self) { item in
//                                ProductList(
//                                    image: nil,
//                                    productName: item.name,
//                                    price: item.price,
//                                    quantity: Binding(
//                                        get: { item.quantity },
//                                        set: { newValue in
//                                            item.quantity = newValue
//                                            try? context.save()
//                                        }
//                                    ),
//                                    variant: .stepper
//                                )
//                            }
//                        }
//                        .padding()
//
//                        VStack {
//                            Divider()
//                            HStack {
//                                Text("Total")
//                                    .font(.headline)
//                                Spacer()
//                                Text("US$ \(items.reduce(0) { $0 + ($1.price * Double($1.quantity)) }, specifier: "%.2f")")
//                                    .bold()
//                            }
//                            .padding(.top, 16)
//                        }
//                        .padding(.horizontal)
//                        .padding(.bottom)
//                    }
//
//                    VStack {
//                        //Spacer()
//                        Button("Checkout") {
//                            print("Ir para pagamento")
//                        }
//                        .foregroundStyle(.labelsPrimary)
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 54)
//                        .background(.fillsTertiary)
//                        .foregroundColor(.white)
//                        .cornerRadius(12)
//                        .padding(.horizontal, 16)
//                        .padding(.vertical, 16)
//                        //.background(.ultraThinMaterial)
//                    }
//                    //.frame(maxHeight: .infinity, alignment: .bottom)
//                }
//            }
//            .navigationTitle("Cart")
//        }
//    }
//}


//struct CartContentView: View {
//    @Bindable var viewModel: CartViewModel
//
//    var body: some View {
//        if viewModel.items.isEmpty {
//            EmptyStateCart()
//        } else {
//            ScrollView {
//                VStack(spacing: 16) {
//                    ForEach(viewModel.items, id: \.self) { item in
//                        ProductList(
//                            image: nil,
//                            productName: item.name,
//                            price: item.price,
//                            quantity: Binding(
//                                get: { item.quantity },
//                                set: { newValue in
//                                    viewModel.updateQuantity(for: item, quantity: newValue)
//                                }
//                            ),
//                            variant: .stepper
//                        )
//                    }
//                }
//                .padding()
//
//                VStack {
//                    Divider()
//                    HStack {
//                        Text("Total")
//                            .font(.headline)
//                        Spacer()
//                        Text("US$ \(viewModel.total, specifier: "%.2f")")
//                            .bold()
//                    }
//                    .padding(.top, 16)
//                }
//                .padding(.horizontal)
//                .padding(.bottom)
//            }
//
//            VStack {
//                //Spacer()
//                Button("Checkout") {
//                    print("Ir para pagamento")
//                }
//                .foregroundStyle(.labelsPrimary)
//                .frame(maxWidth: .infinity)
//                .frame(height: 54)
//                .background(.fillsTertiary)
//                .foregroundColor(.white)
//                .cornerRadius(12)
//                .padding(.horizontal, 16)
//                .padding(.vertical, 16)
//                //.background(.ultraThinMaterial)
//            }
//            //.frame(maxHeight: 54, alignment: .bottom)
//        }
//    }
//}

import SwiftUI
import SwiftData


struct CartView: View {
    @Environment(\.modelContext) private var context

    @Query(filter: #Predicate<Product> { $0.isCart == true })
    private var cartItems: [Product]


    var body: some View {
        if cartItems.isEmpty {
            NavigationStack {
                EmptyStateCart()
            }
            .navigationTitle("Cart")
        } else {
            NavigationStack {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(cartItems) { product in
                            ProductList(
                                image: nil,
                                productName: product.name,
                                price: product.price,
                                quantity: .constant(product.quantity),
                                variant: .stepper
                            )
                            .environment(\.modelContext, context)
                        }
                    }
                    .padding()
                    VStack {
                        Divider()
                        HStack {
                            Text("Total")
                                .font(.headline)
                            Spacer()
                            Text("US$ \(cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }, specifier: "%.2f")")
                                .bold()
                        }
                        .padding(.top, 16)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                VStack {
                    //Spacer()
                    Button("Checkout") {
                        print("Ir para pagamento")
                    }
                    .foregroundStyle(.labelsPrimary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(.fillsTertiary)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    //.background(.ultraThinMaterial)
                }
                //.frame(maxHeight: .infinity, alignment: .bottom)
            }
            .navigationTitle("Cart")
        }
    }
}


