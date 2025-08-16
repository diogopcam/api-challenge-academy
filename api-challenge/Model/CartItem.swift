//
//  CartItem.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 16/08/25.
//

import Foundation
import SwiftData

@Model
class CartItem {
    var name: String
    var price: Double
    var quantity: Int

    init(name: String, price: Double, quantity: Int = 1) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}
