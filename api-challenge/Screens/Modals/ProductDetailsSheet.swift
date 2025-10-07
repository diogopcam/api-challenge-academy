//
//  ProductDetailsSheet.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 15/08/25.
//

import SwiftUI
import SwiftData

struct ProductDetailsSheet: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm: ProductDetailsVM
    
    init(vm: ProductDetailsVM) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack (spacing: 8){
                    Capsule()
                        .frame(width: 40, height: 5)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.top, 8)
                    Text("Details")
                        Divider()
                        .font(.system(size: 17, weight: .semibold))
                        .accessibilityAddTraits(.isHeader)
                }
                .frame(width: 393, height: 54)
                .background(.fillsTertiary)
                .accessibilityElement(children: .combine)
                .accessibilityLabel(NSLocalizedString("Product details section", comment: ""))

                ScrollView{
                    VStack (spacing: 16){
                        VStack {
                            ProductCardVBig(
                                product: vm.product,
                                isFavorited: vm.isProductFavorite(id: vm.product.id),
                                onToggleFavorite: {vm.toggleFavorite(for: vm.product) }
                            )
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel(String(format: NSLocalizedString("Product: %@", comment: ""), vm.product.title))
                            .accessibilityHint(NSLocalizedString("Double tap to favorite or unfavorite this product", comment: ""))
                        }
                        .frame(width: 361)
                        VStack {
                            Text(vm.product.description)
                                .foregroundColor(.secondary)
                                .frame(width: 361, alignment: .leading)
                                .accessibilityValue(vm.product.description)
                            }
                        }
                    .frame(width: 361)
                    }
        
                //.padding(.horizontal)
                .frame(width: 361)

                Button(action: {
                    addToCart()
                    dismiss()
                }) {
                    Text("Add to cart")
                        .foregroundStyle(.labelsPrimary)
                        .frame(height: 54)
                        .frame(maxWidth: .infinity)
                        .background(.fillsTertiary)
                        .cornerRadius(12)
                        .font(.system(size: 17, weight: .semibold))
                }
                .contentShape(Rectangle())
                .padding(.horizontal)
                .padding(.bottom, 8)
                .accessibilityLabel(NSLocalizedString("Add to cart", comment: ""))
                .accessibilityHint(String(format: NSLocalizedString("Adds %@ to your cart", comment: ""), vm.product.title))
                .accessibilityAddTraits(.isButton)
            }
            .background(.backgroundsPrimary)
        }
        .toolbarBackground(.backgroundsTertiary, for: .navigationBar)
              .toolbarBackground(.visible, for: .navigationBar)
          }

    private func addToCart() {
        vm.addToCart()
    }
}
