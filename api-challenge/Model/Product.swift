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
    var name: String
    var info: String
    var category: String
    var price: Double
    var type: ProductType

    init(name: String, info: String, category: String, price: Double, type: ProductType) {
        self.name = name
        self.info = info
        self.category = category
        self.price = price
        self.type = type
    }
}

