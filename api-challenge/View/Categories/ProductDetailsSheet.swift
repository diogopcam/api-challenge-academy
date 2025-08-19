//
//  ProductDetailsSheet.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 15/08/25.
//

import SwiftUI
import SwiftData

//struct ProductDetailsSheet: View {
//    @Environment(\.modelContext) private var modelContext
//    @Binding var cartVM: CartVM
//    
//    let product: ProductDTO
//    @Environment(\.dismiss) var dismiss
//    
//
//    var body: some View {
//        VStack(spacing: 0) {
//            Text("Details")
//                .font(.system(size: 17, weight: .semibold))
//                .padding(.top, 20)
//
//            ScrollView {
//                VStack(spacing: 16) {
//                    ProductCardVBig(product: product)
//                        .padding(.top, 16)
//                        .frame(maxWidth: .infinity)
//
//                    Text(product.description)
//                        .padding()
//                        .frame(width: 361, alignment: .leading)
//                        .foregroundStyle(.labelsSecondary)
//                        .cornerRadius(8)
//                }
//                .padding(.bottom, 20)
//            }
//
//            Button(action: {
////                if cartVM == nil {
////                    cartVM = CartVM(context: modelContext)
////                }
////
////                cartVM?.add(product: product)
//                cartVM.add(product: product)
//                dismiss()
//            }) {
//                Text("Add to cart")
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 54)
//                    .background(.fillsTertiary)
//                    .foregroundColor(.labelsPrimary)
//                    .cornerRadius(12)
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 8)
//            }
//            .background(.backgroundsPrimary)
//        }
//        .presentationDetents([.large])
//        .presentationDragIndicator(.visible)
//    }
//}

//struct ProductDetailsSheet: View {
//    @Environment(\.modelContext) private var modelContext
//    @Binding var cartVM: CartVM
//    var favoritesVM: FavoritesVM
//
//    let product: ProductDTO
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        VStack(spacing: 0) {
//            Text("Details")
//                .font(.system(size: 17, weight: .semibold))
//                .padding(.top, 20)
//
//            ScrollView {
//                VStack(spacing: 16) {
//                    ProductCardVBig(product: product, favoritesVM: favoritesVM)
//                        .padding(.top, 16)
//                        .frame(maxWidth: .infinity)
//
//                    Text(product.description)
//                        .padding()
//                        .frame(width: 361, alignment: .leading)
//                        .foregroundStyle(.labelsSecondary)
//                        .cornerRadius(8)
//                }
//                .padding(.bottom, 20)
//            }
//
//            Button(action: {
//                cartVM.add(product: product)
//                dismiss()
//            }) {
//                Text("Add to cart")
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 54)
//                    .background(.fillsTertiary)
//                    .foregroundColor(.labelsPrimary)
//                    .cornerRadius(12)
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 8)
//            }
//            .background(.backgroundsPrimary)
//        }
//        .presentationDetents([.large])
//        .presentationDragIndicator(.visible)
//    }
//}

//struct ProductDetailsSheet: View {
//    @Environment(\.modelContext) private var modelContext
//    @Binding var cartVM: CartVM
//    @Query private var favorites: [CartItem]
//    
//    let product: ProductDTO
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        VStack(spacing: 0) {
//            Text("Details")
//                .font(.system(size: 17, weight: .semibold))
//                .padding(.top, 20)
//
//            ScrollView {
//                VStack(spacing: 16) {
//                    ProductCardVBig(product: product)
//                        .padding(.top, 16)
//                        .frame(maxWidth: .infinity)
//
//                    Text(product.description)
//                        .padding()
//                        .frame(width: 361, alignment: .leading)
//                        .foregroundStyle(.labelsSecondary)
//                        .cornerRadius(8)
//                }
//                .padding(.bottom, 20)
//            }
//
//            Button(action: {
//                cartVM.add(product: product)
//                dismiss()
//            }) {
//                Text("Add to cart")
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 54)
//                    .background(.fillsTertiary)
//                    .foregroundColor(.labelsPrimary)
//                    .cornerRadius(12)
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 8)
//            }
//            .background(.backgroundsPrimary)
//        }
//        .presentationDetents([.large])
//        .presentationDragIndicator(.visible)
//    }
//}

struct ProductDetailsSheet: View {
    let product: ProductDTO
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var favoritesVM: FavoritesVM?
    @State private var cartVM: CartVM?

    var body: some View {
        VStack {
            Text("Details").font(.title2).padding(.top)

            ProductCardVBig(product: product)
            Text(product.description)
                .foregroundColor(.secondary)
                .padding()

            Button("Add to cart") {
                addToCart()
                dismiss()
            }
            .frame(height: 54)
            .frame(maxWidth: .infinity)
            .background(.fillsTertiary)
            .cornerRadius(12)
            .padding(.horizontal)
        }
        .onAppear {
            cartVM = CartVM(context: context)
            favoritesVM = FavoritesVM(context: context)
        }
    }
    
    private func addToCart() {
            if let existing = try? context.fetch(FetchDescriptor<Product>()).first(where: { $0.id == product.id }) {
                existing.isCart = true
            } else {
                let newProduct = Product(from: product, type: .cart)
                newProduct.isCart = true
                context.insert(newProduct)
            }

            try? context.save()
        }
}




//#Preview {
//    ProductDetailsSheet()
//}
