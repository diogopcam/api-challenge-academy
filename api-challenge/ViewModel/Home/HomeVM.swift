//
//  HomeViewModel.swift
//  api-challenge
//
//  Created by Diogo Camargo on 15/08/25.
//

import SwiftUI

@Observable
final class HomeVM {
    var products: [ProductDTO] = []
    var isLoading = false
    var errorMessage: String?
    private let service: ProductsServiceProtocol
    
    init(service: ProductsServiceProtocol = ProductsService()) {
        self.service = service
    }
    
    @MainActor
    func loadProducts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            products = try await service.fetchProducts()
        } catch {
            errorMessage = error.localizedDescription
            print("Error loading products: \(error)")
        }
        
        isLoading = false
    }
}
