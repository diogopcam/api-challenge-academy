//
//  ProductsService.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

import Foundation

class ProductsService: ProductsServiceProtocol {
    private let baseURL = "https://dummyjson.com/products"
    
    func fetchProducts() async throws -> [String] {
        let urlString = "\(baseURL)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([String].self, from: data)
    }
}
