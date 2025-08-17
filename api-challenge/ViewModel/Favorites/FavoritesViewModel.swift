//
//  FavoritesViewModel.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 17/08/25.
//

import SwiftData
import SwiftUI

//@Observable
//class FavoritesViewModel {
//    private var context: ModelContext
//    @Published var favorites: [FavoriteItem] = []
//
//    init(context: ModelContext) {
//        self.context = context
//        loadFavorites()
//    }
//
//    func loadFavorites() {
//        let descriptor = FetchDescriptor<FavoriteItem>()
//        favorites = (try? context.fetch(descriptor)) ?? []
//    }
//
//    func isFavorited(product: ProductDTO) -> Bool {
//        favorites.contains(where: { $0.id == product.id })
//    }
//
//    func toggleFavorite(for product: ProductDTO) {
//        if let existing = favorites.first(where: { $0.id == product.id }) {
//            context.delete(existing)
//        } else {
//            let item = FavoriteItem(id: product.id, title: product.title, thumbnail: product.thumbnail, price: product.price)
//            context.insert(item)
//        }
//        try? context.save()
//        loadFavorites()
//    }
//}

@Observable
class FavoritesViewModel {
    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func toggleFavorite(_ dto: ProductDTO) {
        if let existing = fetchProduct(by: dto.id) {
            existing.type = existing.type == .favorites ? .none : .favorites
        } else {
            let product = Product(id: dto.id, name: dto.title, info: dto.description, category: dto.category, price: dto.price, type: .favorites)
            context.insert(product)
        }
        try? context.save()
    }

    func isFavorited(_ dto: ProductDTO) -> Bool {
        return fetchProduct(by: dto.id)?.type == .favorites
    }

    private func fetchProduct(by id: Int) -> Product? {
        let descriptor = FetchDescriptor<Product>(predicate: #Predicate { $0.id == id })
        return try? context.fetch(descriptor).first
    }
}
