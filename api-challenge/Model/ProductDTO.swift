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

extension Product {
    convenience init(from dto: ProductDTO, type: ProductType) {
        self.init(
            id: dto.id,
            name: dto.title,
            info: dto.description,
            category: dto.category,
            price: dto.price,
            type: type,
            quantity: 1,
            thumbnail: dto.thumbnail
        )
        self.typeString = type.rawValue
    }
}
