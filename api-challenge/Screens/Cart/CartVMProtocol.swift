//
//  CartVMProtocol.swift
//  api-challenge
//
//  Created by Diogo Camargo on 22/08/25.
//

import SwiftUI
import SwiftData

@MainActor
protocol CartVMProtocol: ObservableObject {
    var cartProducts: [CartProductDisplay] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var checkoutSuccess: Bool { get }
    
    func loadCart() async
    func increaseQuantity(_ product: Product)
    func decreaseQuantity(_ product: Product)
    func totalPrice() -> Double
    func checkout() async
}
