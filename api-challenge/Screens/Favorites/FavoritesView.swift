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
            VStack (spacing: 32) {
                if vm.isLoading {
                    ProgressView()
                } else if let error = vm.errorMessage {
                    ErrorView(message: error) {
                        Task { await vm.loadFavorites() }
                    }
                } else if vm.filteredProducts.isEmpty {
                    EmptyStateFav()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(vm.filteredProducts) { product in
                                Pro(
                                    image: product.thumbnail,
                                    productName: product.title,
                                    price: product.price,
                                    variant: .cart(action: {
                                        selectedProduct = product
                                        showProductDetails = true
                                    })
                                )
                            }
                        }
                        .padding() // ← Espaçamento externo
                    }
                }
            }
            .navigationTitle("Favoritos")
            .searchable(text: $searchText, prompt: "Buscar favoritos")
            .onChange(of: searchText) {_, newValue in
                vm.filterFavorites(by: newValue)
            }
            .sheet(item: $selectedProduct) { product in
                ProductDetailsSheet(
                    vm: ProductDetailsVM(
                        product: product,
                        apiService: vm.apiService,
                        productsService: vm.productsService
                    )
                )
            }
        }
        .task { await vm.loadFavorites() }
    }
}
