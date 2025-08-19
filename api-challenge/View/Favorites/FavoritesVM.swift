//
//  FavoritesVM.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 17/08/25.
//

import SwiftData
import SwiftUI

@Observable
final class FavoritesVM: ObservableObject {
    var favoriteProducts: [FavoriteProductDisplay] = []
    var filteredProducts: [FavoriteProductDisplay] = [] // array filtrado para search
    var isLoading = false
    var errorMessage: String?

    private var productMap: [Int: ProductDTO] = [:]
    private let apiService: ProductsServiceProtocolAPI
    private let userProductsService: any UserProductsServiceProtocol

    init(
        apiService: any ProductsServiceProtocolAPI,
        userProductsService: any UserProductsServiceProtocol
    ) {
        self.apiService = apiService
        self.userProductsService = userProductsService
    }

    @MainActor
    func loadFavorites() async {
        isLoading = true
        errorMessage = nil

        do {
            // busca produtos da API
            let dtoList = try await apiService.fetchProducts()
            productMap = Dictionary(uniqueKeysWithValues: dtoList.map { ($0.id, $0) })

            // busca produtos favoritos persistidos
            let favorites = userProductsService.getFavoriteProducts()

            favoriteProducts = favorites.map { product in
                let dto = productMap[product.id]
                return FavoriteProductDisplay(product: product, dto: dto)
            }

            // inicializa filteredProducts
            filteredProducts = favoriteProducts

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func filterFavorites(by searchText: String) {
        if searchText.isEmpty {
            filteredProducts = favoriteProducts
        } else {
            filteredProducts = favoriteProducts.filter {
                $0.product.name.lowercased().contains(searchText.lowercased())
            }
        }
    }

    func addToCart(_ dto: ProductDTO) {
        print("Produto adicionado no cart!")
        try? userProductsService.addToCart(dto)
    }
    
    func toggleFavorite(_ dto: ProductDTO) {
        do {
            try userProductsService.toggleFavorite(dto)
            // atualiza lista local
            favoriteProducts = userProductsService.getFavoriteProducts().map { product in
                let dto = productMap[product.id]
                return FavoriteProductDisplay(product: product, dto: dto)
            }
            filteredProducts = favoriteProducts
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func fetchProduct(by id: Int) -> Product? {
        return userProductsService.fetchProduct(by: id)
    }
}
