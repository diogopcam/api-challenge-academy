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
    
    func getFavoriteProducts() -> [Product] {
        let descriptor = FetchDescriptor<Product>(
            predicate: #Predicate { $0.isFavorite == true}
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func getOrderedProducts() -> [Product] {
        let descriptor = FetchDescriptor<Product>(
            predicate: #Predicate { $0.isOrder == false }
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func printAllProducts() {
        do {
            let allProducts = try context.fetch(FetchDescriptor<Product>())
            print("=== Produtos Persistidos ===")
            for product in allProducts {
                print("ID: \(product.id), Nome: \(product.name), Categoria: \(product.category), Preço: \(product.price), isFavorite: \(product.isFavorite), isOrder: \(product.isOrder)")
            }
            if allProducts.isEmpty {
                print("Nenhum produto encontrado.")
            }
        } catch {
            print("Erro ao buscar produtos: \(error)")
        }
    }
}

