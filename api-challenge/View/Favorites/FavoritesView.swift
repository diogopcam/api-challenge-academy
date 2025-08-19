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
    
    private func productRow(for item: FavoriteProductDisplay) -> some View {
        let productDTO = ProductDTO(
            id: item.product.id,
            title: item.product.name,
            description: item.product.info,
            category: item.product.category,
            price: item.product.price,
            thumbnail: item.thumbnail ?? ""
        )
        
        return ProductListAsyncImage(
            image: item.thumbnail,
            productName: item.product.name,
            price: item.product.price,
            quantity: .constant(0),
            variant: .cart {
                selectedProduct = productDTO
                showProductDetails = true
                print("Botão pressionado - Sheet deve aparecer")
            }
        )
    }

    var body: some View {
        NavigationStack {
            if vm.isLoading {
                ProgressView()
                    .navigationTitle("Favorites")
            } else if vm.filteredProducts.isEmpty {
                EmptyStateFav()
                    .navigationTitle("Favorites")
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(vm.filteredProducts) { item in
                            productRow(for: item)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Favorites")
                .searchable(text: $searchText, prompt: "Search")
                .onChange(of: searchText) { newValue in
                    vm.filterFavorites(by: newValue)
                }
            }
        }
        // MOVER A SHEET PARA FORA DO NavigationStack
        .sheet(isPresented: $showProductDetails) {
            if let product = selectedProduct {
                ProductDetailsSheet(product: product)
                    .onDisappear {
                        selectedProduct = nil
                    }
            } else {
                Text("Erro: Produto não selecionado")
                    .presentationDetents([.medium])
            }
        }
        .task {
            await vm.loadFavorites()
        }
    }
}
