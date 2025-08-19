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
    @Published var products: [ProductDTO] = []    // Adicione @Published
    @Published var isLoading = false             // Adicione @Published
    @Published var errorMessage: String?
   
    private let apiService: any ProductsServiceProtocolAPI
    private let productsService: any UserProductsServiceProtocol
    
    public var modelContext: ModelContext?
    
    init(apiService: any ProductsServiceProtocolAPI, productsService: any UserProductsServiceProtocol) {
        self.apiService = apiService
        self.productsService = productsService
    }
    
    @MainActor
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
}
