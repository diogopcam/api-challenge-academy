//
//  MockApiService.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 20/08/25.
//

import Foundation
@testable import api_challenge

class MockApiService: ApiServiceProtocol {
    var shouldFail: Bool = false
    private var products: [ProductDTO]
    
    init(shouldFail: Bool = false, products: [ProductDTO] = []) {
        self.shouldFail = shouldFail
        self.products = products.isEmpty ? [
            ProductDTO(id: 1, title: "Test Product 1", description: "Description 1", category: "Favorites", price: 129.99, thumbnail: ""),
            ProductDTO(id: 2, title: "Test Product 2", description: "Description 2", category: "Electronics", price: 299.99, thumbnail: "")
        ] : products
    }
    
    func fetchProduct(id: Int) async throws -> ProductDTO {
        if shouldFail {
            throw NSError(domain: "MockApiService", code: 404, userInfo: nil)
        }
        
        guard let product = products.first(where: { $0.id == id }) else {
            throw NSError(domain: "MockApiService", code: 404, userInfo: nil)
        }
        
        return product
    }
    
    func fetchProducts() async throws -> [ProductDTO] {
        if shouldFail {
            throw NSError(domain: "MockApiService", code: 500, userInfo: nil)
        }
        return products
    }
    
    func fetchCategories() async throws -> [String] {
        if shouldFail {
            throw NSError(domain: "MockApiService", code: 500, userInfo: nil)
        }
        return Array(Set(products.map { $0.category }))
    }
    
    func loadProductsFromCategory(for category: String) async throws -> [ProductDTO] {
        if shouldFail {
            throw NSError(domain: "MockApiService", code: 500, userInfo: nil)
        }
        return products.filter { $0.category == category }
    }
}
