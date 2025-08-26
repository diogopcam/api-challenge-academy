//
//  CartProductDisplay.swift
//  api-challenge
//
//  Created by Diogo Camargo on 19/08/25.
//

struct CartProductDisplay: Identifiable, Equatable {
    let product: Product
    let dto: ProductDTO?
    
    var id: Int { product.id }
    var thumbnail: String? {
        dto?.thumbnail
    }
    
    // Equatable apenas com id
    static func == (lhs: CartProductDisplay, rhs: CartProductDisplay) -> Bool {
        lhs.id == rhs.id
    }
}
