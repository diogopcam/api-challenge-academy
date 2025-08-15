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
    var type: ProductType
    var name: String
    var info: String
    var category: String
    var quantity: Int
    var addedDate: Date
    var price: Double
    
    init(name: String,
         info: String,
         category: String,
         price: Double,
         type: ProductType,
         quantity: Int = 1) {
        
        self.name = name
        self.info = info
        self.category = category
        self.price = price
        self.type = type
        self.quantity = quantity
        self.addedDate = Date()
    }
}
