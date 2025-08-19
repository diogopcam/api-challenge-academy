//
//  FavoritesView.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 17/08/25.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var vm: FavoritesVM
    @State private var searchText = ""
    @State private var selectedProduct: ProductDTO?
    @State private var showProductDetails = false
    
    init(vm: FavoritesVM) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.isLoading {
                    ProgressView()
                } else if let error = vm.errorMessage {
                    ErrorView(message: error) {
                        Task { await vm.loadFavorites() }
                    }
                } else if vm.filteredProducts.isEmpty {
                    EmptyStateFav()
                } else {
                    List(vm.filteredProducts) { product in
                        ProductListAsyncImage(
                            image: product.thumbnail,
                            productName: product.title,
                            price: product.price,
                            variant: .cart(
                                action: {
                                    selectedProduct = product
                                    showProductDetails = true
                                }
                            )
//                            product: product,
//                            onAddToCart: { vm.addToCart(product) },
//                            onToggleFavorite: { vm.toggleFavorite(product) }
                        )
//                        ProductListAsyncImage(image: product.thumbnail, productName: product.title, price: product.price, variant: .delivery(month: "DECEMBER", day: "15"))
//                        .onTapGesture {
//                            selectedProduct = product
//                            showProductDetails = true
//                        }
                    }
                }
            }
            .navigationTitle("Favoritos")
            .searchable(text: $searchText, prompt: "Buscar favoritos")
            .onChange(of: searchText) { vm.filterFavorites(by: $0) }
            .sheet(isPresented: $showProductDetails) {
                if let product = selectedProduct {
                    ProductDetailsSheet(product: product)
                }
            }
        }
        .task { await vm.loadFavorites() }
    }
}
