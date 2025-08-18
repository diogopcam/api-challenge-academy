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
    @State private var viewModel: FavoritesViewModel?

    var body: some View {
        NavigationStack {
            if let viewModel = viewModel {
                if viewModel.isLoading {
                    ProgressView().navigationTitle("Favorites")
                } else if viewModel.favoriteProducts.isEmpty {
                    EmptyStateFav().navigationTitle("Favorites")
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.favoriteProducts) { item in
                                ProductListAsyncImage(
                                    thumbnailURL: item.thumbnail,
                                    productName: item.product.name,
                                    price: item.product.price,
                                    quantity: .constant(1),
                                    variant: .cart {
                                        let cartVM = CartViewModel(context: context)
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
            let vm = FavoritesViewModel(context: context)
            await vm.loadFavorites()
            viewModel = vm
        }
    }
}
