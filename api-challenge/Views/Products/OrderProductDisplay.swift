//
//  OrderProductDisplay.swift
//  api-challenge
//
//  Created by Diogo Camargo on 26/08/25.
//

import Foundation

struct OrderProductDisplay: Identifiable, Equatable {
    let product: ProductDTO        // Produto principal da API
    let quantity: Int              // Quantidade pedida
    let dateOrdered: Date         // Data do pedido, opcional
    
    var id: Int { product.id }     // Identificador único
    var thumbnail: String? { product.thumbnail } // Url da imagem
    var title: String { product.title }           // Nome do produto
    var price: Double { product.price }          // Preço
    
    // Equatable apenas pelo id
    static func == (lhs: OrderProductDisplay, rhs: OrderProductDisplay) -> Bool {
        lhs.id == rhs.id
    }
}
