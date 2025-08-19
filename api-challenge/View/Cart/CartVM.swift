//
//  CartVM.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 16/08/25.
//

import SwiftUI
import SwiftData


@Observable
final class CartVM {
    var cartProducts: [CartProductDisplay] = []
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
    func loadCart() async {
        isLoading = true
        errorMessage = nil

        do {
            let dtoList = try await service.fetchProducts()
            productMap = Dictionary(uniqueKeysWithValues: dtoList.map { ($0.id, $0) })

            let cartItems = try context.fetch(
                FetchDescriptor<Product>(predicate: #Predicate { $0.isCart == true })
            )

            cartProducts = cartItems.map { product in
                let dto = productMap[product.id]
                return CartProductDisplay(product: product, dto: dto)
            }

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func addToCart(_ dto: ProductDTO) {
        if let existing = fetchProduct(by: dto.id) {
            existing.isCart = true
            existing.quantity += 1
        } else {
            let product = Product(
                id: dto.id,
                name: dto.title,
                info: dto.description,
                category: dto.category,
                price: dto.price,
                type: .cart,
                thumbnail: dto.thumbnail
            )
            product.isCart = true
            product.quantity = 1
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
            product.isCart = false
            product.type = .none
            product.quantity = 1
        }
        try? context.save()
    }

    func totalPrice() -> Double {
        cartProducts.reduce(0) { $0 + ($1.product.price * Double($1.product.quantity)) }
    }

    private func fetchProduct(by id: Int) -> Product? {
        let descriptor = FetchDescriptor<Product>(predicate: #Predicate { $0.id == id })
        return try? context.fetch(descriptor).first
    }
}

struct CartProductDisplay: Identifiable {
    let product: Product
    let dto: ProductDTO?

    var id: Int { product.id }
    var thumbnail: String? { dto?.thumbnail }
}
