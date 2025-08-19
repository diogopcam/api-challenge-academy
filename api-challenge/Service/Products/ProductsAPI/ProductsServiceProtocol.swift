//
//  ProductsServiceProtocol 2.swift
//  api-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//

protocol ProductsServiceProtocolAPI {
    func fetchProducts() async throws -> [ProductDTO]
    
    func fetchProduct(id: Int) async throws -> ProductDTO
}
