//
//  ProductsService.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

import Foundation

class ProductsServiceAPI: ProductsServiceProtocolAPI {
    private let baseURL = "https://dummyjson.com/products"
    
    func fetchProducts() async throws -> [ProductDTO] {
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(ProductsResponseDTO.self, from: data)
        return decoded.products
    }
    
    func fetchProduct(id: Int) async throws -> ProductDTO {
        // Constrói a URL específica para o produto
        let productURL = "\(baseURL)/\(id)"
        guard let url = URL(string: productURL) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        // Verifica se o status code é 200 (OK) ou 404 (Not Found)
        switch httpResponse.statusCode {
        case 200:
            // Produto encontrado - decodifica normalmente
            do {
                let product = try JSONDecoder().decode(ProductDTO.self, from: data)
                return product
            } catch {
                throw URLError(.badURL)
            }
            
        case 404:
            // Produto não encontrado
            throw URLError(.badURL)
            
        default:
            // Outro erro do servidor
            throw URLError(.badURL)
        }
    }
}
