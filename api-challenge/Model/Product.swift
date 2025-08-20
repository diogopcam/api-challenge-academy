//
//  ProductSaveType.swift
//  api-challenge
//
//  Created by Diogo Camargo on 15/08/25.
//

import SwiftData
import SwiftUI

@Model
final class Product {
    @Attribute(.unique) var id: Int
    var category: String
    var quantity: Int
    var isFavorite: Bool = false
    var isCart: Bool = false
    var isOrder: Bool = false
    
    init(id: Int, category: String, quantity: Int = 1) {
        self.id = id
        self.category = category
        self.quantity = quantity
    }
}

