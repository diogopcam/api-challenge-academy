//
//  Product.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 13/08/25.
//

struct ProductDTO: Identifiable, Decodable {
    var id: Int
    var title: String
    var description: String
    var category: String
    var price: Double
    var thumbnail: String
}
