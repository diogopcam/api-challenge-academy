//
//  CategoryProductsVMProtocol.swift
//  api-challenge
//
//  Created by Diogo Camargo on 22/08/25.
//

import Foundation

@MainActor
protocol CategoryProductsVMProtocol: ObservableObject {
    var categoryName: String { get }
    var products: [ProductDTO] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func loadProducts() async
    func isProductFavorite(id: Int) -> Bool
    func toggleFavorite(for product: ProductDTO)
}
