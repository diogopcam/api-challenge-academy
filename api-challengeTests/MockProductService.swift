//
//  MockProductService.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 20/08/25.
//

import Foundation
@testable import api_challenge

class MockProductService: ProductsServiceProtocolAPI {
    
    var shouldFail: Bool = false
    private var product: ProductDTO
    
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
        self.product = ProductDTO(id: 1, title: "test", description: "Description of tests", category: "Favorites", price: 129.99, thumbnail: "")
    }
    
    
    func fetchProduct(id: Int) async throws -> api_challenge.ProductDTO {
        if shouldFail {
            throw NSError(domain: #function, code: 2)
        } else {
            return product
        }
    }
    
    func fetchProducts() async throws -> [api_challenge.ProductDTO] {
        if shouldFail {
            throw NSError(domain: #function, code: 1)
        } else {
            return [product]
        }
    }
    
    
}
