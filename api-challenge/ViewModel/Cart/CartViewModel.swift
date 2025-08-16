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
    var items: [CartItem] = [] // Sem @Published
    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
        fetchItems()
    }

    func fetchItems() {
        let descriptor = FetchDescriptor<CartItem>()
        do {
            items = try context.fetch(descriptor)
        } catch {
            print("Erro ao buscar itens do carrinho: \(error)")
        }
    }

    func add(product: ProductDTO) {
        let productName = product.title

        let descriptor = FetchDescriptor<CartItem>(
            predicate: #Predicate { $0.name == productName }
        )

        do {
            let existingItems = try context.fetch(descriptor)

            if let existing = existingItems.first {
                existing.quantity += 1
            } else {
                let newItem = CartItem(name: product.title, price: product.price)
                context.insert(newItem)
            }

            try context.save()
            fetchItems() // 🔁 sempre recarrega após salvar para garantir consistência
        } catch {
            print("Erro ao adicionar item ao carrinho: \(error)")
        }
    }




    func updateQuantity(for item: CartItem, quantity: Int) {
        item.quantity = quantity
        try? context.save()
    }

    func remove(item: CartItem) {
        context.delete(item)
        try? context.save()
        fetchItems()
    }

    var total: Double {
        items.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
}
