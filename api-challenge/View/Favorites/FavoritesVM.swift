//
//  FavoritesVM.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 17/08/25.
//

import SwiftData
import SwiftUI

@MainActor
final class FavoritesVM: ObservableObject {
    @Published var favoriteProducts: [ProductDTO] = []
    @Published var filteredProducts: [ProductDTO] = []
    @Published var quantities: [Int: Int] = [:] // Se precisar de quantidades
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let apiService: any ProductsServiceProtocolAPI
    let productsService: any UserProductsServiceProtocol
    
    init(apiService: any ProductsServiceProtocolAPI, productsService: any UserProductsServiceProtocol) {
        self.apiService = apiService
        self.productsService = productsService
    }
    
    func loadFavorites() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // 1. Pega IDs dos favoritos
            let persistedFavorites = productsService.getFavoriteProducts()
            let favoriteIDs = persistedFavorites.map { $0.id }
            
            // 2. Busca dados atualizados
            var productsMap: [Int: ProductDTO] = [:]
            
            for persistedProduct in persistedFavorites {
                do {
                    let productDTO = try await apiService.fetchProduct(id: persistedProduct.id)
                    productsMap[productDTO.id] = productDTO
                } catch {
                    print("Erro ao buscar produto \(persistedProduct.id): \(error)")
                }
            }
            
            // 3. Converte para array
            favoriteProducts = Array(productsMap.values)
            filteredProducts = favoriteProducts
            
        } catch {
            errorMessage = "Erro ao carregar favoritos: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func filterFavorites(by searchText: String) {
        if searchText.isEmpty {
            filteredProducts = favoriteProducts
        } else {
            filteredProducts = favoriteProducts.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func toggleFavorite(_ dto: ProductDTO) {
        do {
            try productsService.toggleFavorite(dto)
            Task {
                await loadFavorites()
            }
        } catch {
            errorMessage = "Erro ao alternar favorito: \(error.localizedDescription)"
        }
    }
    
    func addToCart(_ dto: ProductDTO) {
        do {
            try productsService.addToCart(dto)
            print("✅ \(dto.title) adicionado ao carrinho")
        } catch {
            errorMessage = "Erro ao adicionar ao carrinho: \(error.localizedDescription)"
        }
    }
}
