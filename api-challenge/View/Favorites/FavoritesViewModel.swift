//
//  FavoritesVM.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 17/08/25.
//

import SwiftData
import SwiftUI

@Observable
final class FavoritesVM {
    var favoriteProducts: [FavoriteProductDisplay] = []
    var isLoading = false
    var errorMessage: String?
    private var productMap: [Int: ProductDTO] = [:]
    
    private let context: ModelContext
    private let service: ProductsServiceProtocolAPI

    init(context: ModelContext, service: ProductsServiceProtocolAPI = ProductsServiceAPI()) {
        self.context = context
        self.service = service
    }

    @MainActor
    func loadFavorites() async {
        isLoading = true
        errorMessage = nil

        do {
            let dtoList = try await service.fetchProducts()
            productMap = Dictionary(uniqueKeysWithValues: dtoList.map { ($0.id, $0) })

            let favorites = try context.fetch(
                FetchDescriptor<Product>(predicate: #Predicate { $0.isFavorite == true })
            )

            favoriteProducts = favorites.map { product in
                let dto = productMap[product.id]
                return FavoriteProductDisplay(product: product, dto: dto)
            }

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    
    func toggleFavorite(_ dto: ProductDTO) {
        if let existing = fetchProduct(by: dto.id) {
            existing.type = existing.type == .favorites ? .none : .favorites
        } else {
            let product = Product(
                id: dto.id,
                name: dto.title,
                info: dto.description,
                category: dto.category,
                price: dto.price,
                type: .favorites,
                thumbnail: dto.thumbnail
            )
            context.insert(product)
        }

        try? context.save()
    }

    func isFavorited(_ dto: ProductDTO) -> Bool {
        return fetchProduct(by: dto.id)?.type == .favorites
    }

    private func fetchProduct(by id: Int) -> Product? {
        let descriptor = FetchDescriptor<Product>(
            predicate: #Predicate { $0.id == id }
        )
        return try? context.fetch(descriptor).first
    }
}


struct FavoriteProductDisplay: Identifiable {
    let product: Product
    let dto: ProductDTO?

    var id: Int { product.id }
    var thumbnail: String? { dto?.thumbnail }
}
