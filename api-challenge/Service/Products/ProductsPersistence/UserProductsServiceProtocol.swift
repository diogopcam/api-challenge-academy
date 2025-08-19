//
//  UserProductsServiceProtocol.swift
//  api-challenge
//
//  Created by Diogo Camargo on 18/08/25.
//

import SwiftUI

protocol UserProductsServiceProtocol: ObservableObject {
//    func getUserProducts(userId: Int) -> [Product]
    
    func getFavoriteProducts() -> [Product]
    
    func getOrderedProducts() -> [Product]
    
    func printAllProducts() -> Void
    
//    func updateProductAttributes(id: Int, isFavorite: Bool, isOrder: Bool) -> Void
    
//    func getCardProducts() -> [Product]
}
