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
                VStack(spacing: 8) {
                    Capsule()
                        .frame(width: 40, height: 5)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.top, 8)
                    
                    Text("Details")
                        .font(.system(size: 17, weight: .semibold))
                    
                    Divider()
                }
                .frame(width: 393, height: 54)
                .background(.fillsTertiary)
                
                ScrollView {
                    VStack {
                        ProductCardVBig(
                            product: vm.product,
                            isFavorited: vm.isProductFavorite(id: vm.product.id),
                            onToggleFavorite: { vm.toggleFavorite(for: vm.product) }
                        )
                        
                        Text(vm.product.description)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                
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
