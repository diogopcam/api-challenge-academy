//
//  MockUserProductService.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 20/08/25.
//

import Foundation
@testable import api_challenge

class MockUserProductService: UserProductsServiceProtocol {
    
        private var products: [Product] = []


        init() {
            // Produtos de teste
            let product = Product(id: 1, category: "test")
            product.isFavorite = true
            let product2 = Product(id: 2, category: "test2")
            product2.isFavorite = false
            let product3 = Product(id: 3, category: "test3")
            product3.isCart = true
        
            
            products.append(product)
            products.append(product2)
        }

        func getFavoriteProducts() -> [Product] {
            var products2: [Product] = []
            for product in products {
                if product.isFavorite {
                    products2.append(product)
                }
            }
            return products2
        }

        func isProductFavorite(id: Int) -> Bool {
           if let existing = fetchProduct(by: id) {
                return existing.isFavorite
            }
            return false
        }

        func getOrderedProducts() -> [Product] {
            var products2: [Product] = []
            for product in products {
                if product.isOrder {
                    products2.append(product)
                }
            }
            return products2
        }

        func getCartProducts() throws -> [Product] {
            var products2: [Product] = []
            for product in products {
                if product.isCart {
                    products2.append(product)
                }
            }
            return products2
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
                products.append(product)
            }
        }

        func increaseQuantity(_ product: Product) throws {
            product.quantity += 1
        }

        func decreaseQuantity(_ product: Product) throws {
            if product.quantity > 1 {
                product.quantity -= 1
            } else {
                product.isCart = false
                product.quantity = 1
            }
        }

        func printAllProducts() {
            for p in products {
                print(p)
            }
        }

        func fetchProduct(by id: Int) -> Product? {
            return products.first(where: { $0.id == id })
        }

        func toggleFavorite(_ dto: ProductDTO) throws {
            if let existing = fetchProduct(by: dto.id) {
                if existing.isFavorite {
                    existing.isFavorite = false
                } else {
                    existing.isFavorite = true
                }
            } else {
                 return
            }
        }
        
        func checkoutCartProducts() throws {
            for product in products {
                if product.isCart == true {
                    product.isCart = false
                    product.isOrder = true
                    print(product)
                }
            }
        }
    
    
    
    
}
