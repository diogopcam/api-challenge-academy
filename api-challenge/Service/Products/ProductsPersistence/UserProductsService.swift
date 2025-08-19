//
//  UserProductsService.swift
//  api-challenge
//
//  Created by Diogo Camargo on 18/08/25.
//

import Foundation
import SwiftData

final class UserProductsService: UserProductsServiceProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchProduct(by id: Int) -> Product? {
        let descriptor = FetchDescriptor<Product>(predicate: #Predicate { $0.id == id })
        return try? context.fetch(descriptor).first
    }
    
    func getFavoriteProducts() -> [Product] {
        let descriptor = FetchDescriptor<Product>(
            predicate: #Predicate { $0.isFavorite == true}
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func getOrderedProducts() -> [Product] {
        let descriptor = FetchDescriptor<Product>(
            predicate: #Predicate { $0.isOrder == true }
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func printAllProducts() {
        do {
            let allProducts = try context.fetch(FetchDescriptor<Product>())
            print("=== Produtos Persistidos ===")
//            init(id: Int, category: String, quantity: Int = 1) {
//                self.id = id
//                self.category = category
//                self.quantity = quantity
//            }
            for product in allProducts {
                print("ID: \(product.id), Categoria: \(product.category), Quantidade: \(product.quantity)")
            }
            if allProducts.isEmpty {
                print("Nenhum produto encontrado.")
            }
        } catch {
            print("Erro ao buscar produtos: \(error)")
        }
    }
    
    func getCartProducts() throws -> [Product] {
        let descriptor = FetchDescriptor<Product>(
            predicate: #Predicate { $0.isCart == true }
        )
        return try context.fetch(descriptor)
    }
    
    func addToCart(_ dto: ProductDTO) throws {
        if let existing = fetchProduct(by: dto.id) {
            if existing.isCart {
                // Se já está no carrinho, apenas incrementa
                existing.quantity += 1
            } else {
                // Se não está no carrinho, adiciona com quantidade 1
                existing.isCart = true
                existing.quantity = 1
            }
        } else {
            // Produto novo no carrinho
            let product = Product(
                id: dto.id,
                category: dto.category
            )
            product.isCart = true
            product.quantity = 1
            context.insert(product)
        }
        
        try context.save()
    }
    
    func increaseQuantity(_ product: Product) throws {
        product.quantity += 1
        try context.save()
    }
    
    func decreaseQuantity(_ product: Product) throws {
        if product.quantity > 1 {
            product.quantity -= 1
        } else {
            product.isCart = false
            product.quantity = 1
        }
        try context.save()
    }
    
    func toggleFavorite(_ dto: ProductDTO) throws {
        if let existing = fetchProduct(by: dto.id) {
            existing.isFavorite.toggle()
        } else {
            // ✅ Cria novo produto marcado como favorito
            let product = Product(
                id: dto.id,
                category: dto.category
            )
            product.isFavorite = true // ← Define como favorito
            context.insert(product)
        }

        try context.save()
    }
    
    func checkoutCartProducts() throws {
            let descriptor = FetchDescriptor<Product>(
                predicate: #Predicate { $0.isCart == true }
            )
            
            let cartProducts = try context.fetch(descriptor)
            
            for product in cartProducts {
                product.isCart = false
                product.isOrder = true
            }
            
            try context.save()
            
            print("=== CHECKOUT CONCLUÍDO ===")
            print("Produtos movidos para pedidos: \(cartProducts.count)")
            for product in cartProducts {
                print("ID: \(product.id), Categoria: \(product.category), Quantidade: \(product.quantity)")
            }
        }

}

