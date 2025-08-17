//
//  ProductSaveType.swift
//  api-challenge
//
//  Created by Diogo Camargo on 15/08/25.
//

enum ProductType: String, Codable {
    case favorites
    case purchased
    case cart
    case none
}
