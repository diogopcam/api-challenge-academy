//
//  ProductsServiceProtocol 2.swift
//  api-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//

protocol ProductsServiceProtocol {
    func fetchProducts() async throws -> [String]
}
