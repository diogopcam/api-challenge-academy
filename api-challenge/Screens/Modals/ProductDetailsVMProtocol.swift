//
//  ProductDetailsVMProtocol.swift
//  api-challenge
//
//  Created by Diogo Camargo on 21/08/25.
//


import Foundation
import SwiftUI

@MainActor
protocol ProductDetailsVMProtocol: ObservableObject {
    var product: ProductDTO { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func addToCart()
    func isProductFavorite(id: Int) -> Bool
    func toggleFavorite(for product: ProductDTO)
}
