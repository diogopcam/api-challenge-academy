//
//  UserProductsServiceProtocol.swift
//  api-challenge
//
//  Created by Diogo Camargo on 18/08/25.
//

import SwiftUI

protocol UserProductsServiceProtocol: ObservableObject {
    
    func getFavoriteProducts() -> [Product]
   
    func isProductFavorite(id: Int) -> Bool
    
    func getOrderedProducts() -> [Product]
    
    func getCartProducts() throws -> [Product]
    
    func addToCart(_ dto: ProductDTO) throws
    
    func increaseQuantity(_ product: Product) throws
    
    func decreaseQuantity(_ product: Product) throws
    
    func printAllProducts() -> Void
    
    func fetchProduct(by id: Int) -> Product?
    
    func toggleFavorite(_ dto: ProductDTO) throws
    
    func checkoutCartProducts() throws
}
