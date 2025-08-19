//
//  ProductCardStyle.swift
//  api-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//


enum ProductListStyle {
    case stepper(onIncrement: () -> Void, onDecrement: () -> Void)
    case cart(action: () -> Void)
    case delivery(month: String, day: String)
}
