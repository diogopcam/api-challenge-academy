//
//  HomeVM.swift
//  api-challenge
//
//  Created by Diogo Camargo on 15/08/25.
//

import SwiftUI
import SwiftData

@MainActor
final class HomeVM: ObservableObject {
    @Published var products: [ProductDTO] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    let apiService: any ApiServiceProtocol
    let productsService: any UserProductsServiceProtocol
    
    init(apiService: any ApiServiceProtocol, productsService: any UserProductsServiceProtocol) {
        self.apiService = apiService
        self.productsService = productsService
    }
    
    func loadProducts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            products = try await apiService.fetchProducts()
        } catch {
            errorMessage = error.localizedDescription
            print("Error loading products: \(error)")
        }
        
        isLoading = false
    }
    
    func isProductFavorite(id: Int) -> Bool {
        return productsService.isProductFavorite(id: id)
    }
    
    func toggleFavorite(for product: ProductDTO) {
            do {
                try productsService.toggleFavorite(product)
                objectWillChange.send()
            } catch {
                print("Erro ao alternar favorito: \(error)")
            }
    }
}
