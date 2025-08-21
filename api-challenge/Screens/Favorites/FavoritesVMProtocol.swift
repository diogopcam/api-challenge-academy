//
//  FavoritesVMProtocol.swift
//  api-challenge
//
//  Created by Diogo Camargo on 21/08/25.
//

import Foundation

@MainActor
protocol FavoritesVMProtocol: AnyObject {
    var favoriteProducts: [ProductDTO] { get }
    var filteredProducts: [ProductDTO] { get }
    var quantities: [Int: Int] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func loadFavorites() async
    func filterFavorites(by searchText: String)
    func toggleFavorite(_ dto: ProductDTO)
    func addToCart(_ dto: ProductDTO)
}
