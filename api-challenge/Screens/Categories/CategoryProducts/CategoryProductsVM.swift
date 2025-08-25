//
//  CategoryProductsVM.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 15/08/25.
//

import SwiftUI
import SwiftData

@MainActor
class CategoryProductsVM: CategoryProductsVMProtocol {
    var categoryName: String
    
    @Published var products: [ProductDTO] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    let apiService: any ApiServiceProtocol
    let productsService: any UserProductsServiceProtocol

    init(categoryName: String, apiService: any ApiServiceProtocol, productsService: any UserProductsServiceProtocol) {
        self.apiService = apiService
        self.productsService = productsService
        self.categoryName = categoryName
    }
    
    func loadProducts() async {
        isLoading = true
        errorMessage = nil

        do {
            print("Loading category:", categoryName)
            let fetchedProducts = try await apiService.loadProductsFromCategory(for: categoryName)
            products = fetchedProducts
        } catch {
            errorMessage = error.localizedDescription
            products = []
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
