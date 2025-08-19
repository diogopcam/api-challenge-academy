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
    var name: String
    var info: String
    var category: String
    var price: Double
    var type: ProductType
    var typeString: String
    var quantity: Int
    var isFavorite: Bool = false
    var isCart: Bool = false
    var isOrder: Bool = false
    var thumbnail: String?
    
    init(id: Int, name: String, info: String, category: String, price: Double, type: ProductType = .none, quantity: Int = 1, thumbnail: String) {
        self.id = id
        self.name = name
        self.info = info
        self.category = category
        self.price = price
        self.type = type
        self.typeString = type.rawValue
        self.quantity = quantity
        self.thumbnail = thumbnail
    }
}

