//
//  CategoryProductsVM.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 15/08/25.
//

import SwiftUI
import SwiftData

@Observable
class CategoryProductsVM {
    var products: [ProductDTO] = []
    var isLoading = false
    var errorMessage: String?

    private let service: ProductsServiceProtocolAPI

    init(service: ProductsServiceProtocolAPI = ProductsServiceAPI()) {
        self.service = service
    }

    func loadProducts(for category: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let urlString = "https://dummyjson.com/products/category/\(category)"
            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }

            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(ProductsResponseDTO.self, from: data)
            products = decoded.products
        } catch {
            errorMessage = "Erro ao carregar produtos: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
