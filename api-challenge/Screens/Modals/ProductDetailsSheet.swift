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
                }
                .frame(width: 393, height: 54)
                .background(.fillsTertiary)
                ScrollView{
                    VStack (spacing: 16){
                        VStack {
                            ProductCardVBig(
                                product: vm.product,
                                isFavorited: vm.isProductFavorite(id: vm.product.id),
                                onToggleFavorite: {vm.toggleFavorite(for: vm.product) }
                            )
                        }
                        .frame(width: 361)
                        VStack {
                            Text(vm.product.description)
                                .foregroundColor(.secondary)
                                .frame(width: 361, alignment: .leading)
                            }
                        }
                    .frame(width: 361)
                    }
        
                //.padding(.horizontal)
                .frame(width: 361)

                Button("Add to cart") {
                    addToCart()
                    dismiss()
                }
                .foregroundStyle(.labelsPrimary)
                .frame(height: 54)
                .frame(maxWidth: .infinity)
                .background(.fillsTertiary)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.bottom, 8)
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
