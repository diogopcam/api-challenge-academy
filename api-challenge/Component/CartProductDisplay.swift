//
//  CartProductDisplay.swift
//  api-challenge
//
//  Created by Diogo Camargo on 19/08/25.
//


struct CartProductDisplay: Identifiable {
    let product: Product
    let dto: ProductDTO?
    var id: Int { product.id }
    var thumbnail: String? {
        dto?.thumbnail
    }
}

