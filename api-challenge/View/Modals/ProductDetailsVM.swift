//
//  ProductDetailsVM.swift
//  api-challenge
//
//  Created by Diogo Camargo on 20/08/25.
//

import Foundation

@MainActor
final class ProductDetailsVM: ObservableObject {
    @Published var product: ProductDTO
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiService: any ApiServiceProtocol
    private let productsService: any UserProductsServiceProtocol

    init(product: ProductDTO, apiService: any ApiServiceProtocol, productsService: any UserProductsServiceProtocol) {
        self.product = product
        self.productsService = productsService
        self.apiService = apiService
    }

    func addToCart() {
        do {
            try productsService.addToCart(product)
        } catch {
            errorMessage = "Erro ao adicionar ao carrinho"
            print(error)
        }
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
