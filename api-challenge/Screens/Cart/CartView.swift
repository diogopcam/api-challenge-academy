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
    
    private func cartProductRow(for item: CartProductDisplay) -> some View {
        let productName = item.dto?.title ?? "Nulo"
        let price = item.dto?.price ?? 0.00
        let thumbnail = item.dto?.thumbnail
        
        return ProductCell(
            image: thumbnail,
            productName: productName,
            price: price,
            quantity: Binding(
                get: { item.product.quantity },
                set: { _ in }
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

    private var checkoutSection: some View {
        VStack {
            Divider()
            HStack {
                Text("Total")
                    .font(.headline)
                    .accessibilityLabel(Text("Total"))
                    .accessibilityHint("Total of all items in the cart")
                Spacer()
                Text(totalPriceText)
                    .bold()
            }
            .padding(.top, 16)
            .padding(.horizontal)
            
            Button(action: {
                showingCheckoutAlert = true
            }) {
                Text("Checkout")
                    .foregroundStyle(.labelsPrimary)
                    .frame(height: 54)
                    .frame(maxWidth: .infinity)
                    .background(.fillsTertiary)
                    .cornerRadius(12)
                    .font(.system(size: 17, weight: .semibold))

            }
            .foregroundStyle(.labelsPrimary)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(.fillsTertiary)
            .cornerRadius(12)
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .accessibilityHint("Tap in Checkout for proceed to payment")
        }
    }
    
    private var totalPriceText: String {
        let total = vm.totalPrice()
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"     // força dólar americano
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: total)) ?? "US$ \(total)"
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
                                cartProductRow(for: item)
                                    .transition(.move(edge: .trailing).combined(with: .opacity))
                            }
                        }
                        .animation(.easeInOut, value: vm.cartProducts)
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
        .alert("Confirm Checkout", isPresented: $showingCheckoutAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Confirm") {
                Task {
                    await vm.checkout()
                }
            }
        } message: {
            Text("Finalize purchase of \(vm.cartProducts.count) itens for \(totalPriceText)?")
        }
        .alert("Purchase completed", isPresented: $vm.checkoutSuccess) {
            Button("OK") { dismiss() }
        } message: {
            Text("Your order was placed successfully!")
        }
        .task {
            await vm.loadCart()
        }
        .refreshable {
            await vm.loadCart()
        }
    }
}

extension Double {
    var formattedPriceDouble: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: self)) ?? String(format: "%.2f", self)
    }
    
    var formattedDecimal: String {
        String(format: "%.2f", self)
    }
}
