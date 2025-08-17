//
//  CartViewModel.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 16/08/25.
//

import SwiftUI
import SwiftData


@Observable
class CartViewModel {
    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func addToCart(_ productDTO: ProductDTO) {
        if let existing = fetchProduct(by: productDTO.id) {
            existing.type = .cart
            existing.quantity += 1
        } else {
            let product = Product(id: productDTO.id, name: productDTO.title, info: productDTO.description, category: productDTO.category, price: productDTO.price, type: .cart)
            context.insert(product)
        }
        try? context.save()
    }

    func increaseQuantity(_ product: Product) {
        product.quantity += 1
        try? context.save()
    }

    func decreaseQuantity(_ product: Product) {
        if product.quantity > 1 {
            product.quantity -= 1
        } else {
            product.type = .none
            product.quantity = 1
        }
        try? context.save()
    }

    private func fetchProduct(by id: Int) -> Product? {
        let descriptor = FetchDescriptor<Product>(predicate: #Predicate { $0.id == id })
        return try? context.fetch(descriptor).first
    }
}
