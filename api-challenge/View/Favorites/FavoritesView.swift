//
//  FavoritesView.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 17/08/25.
//


import SwiftData
import SwiftUI

struct FavoritesView: View {
    @Environment(\.modelContext) private var context
    @State private var VM: FavoritesVM?

    var body: some View {
        NavigationStack {
            if let VM = VM {
                if VM.isLoading {
                    ProgressView().navigationTitle("Favorites")
                } else if VM.favoriteProducts.isEmpty {
                    EmptyStateFav().navigationTitle("Favorites")
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(VM.favoriteProducts) { item in
                                ProductListAsyncImage(
                                    image: item.thumbnail,
                                    productName: item.product.name,
                                    price: item.product.price,
                                    quantity: .constant(1),
                                    variant: .cart {
                                        let cartVM = CartVM(context: context)
                                        cartVM.addToCart(
                                            ProductDTO(
                                                id: item.product.id,
                                                title: item.product.name,
                                                description: item.product.info,
                                                category: item.product.category,
                                                price: item.product.price,
                                                thumbnail: item.thumbnail ?? ""
                                            )
                                        )
                                    }
                                )
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Favorites")
                }
            } else {
                ProgressView().navigationTitle("Favorites")
            }
        }
        .task {
            let vm = FavoritesVM(context: context)
            await vm.loadFavorites()
            VM = vm
        }
    }
}
