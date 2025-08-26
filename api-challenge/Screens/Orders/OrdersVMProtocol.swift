//
//  OrdersVMProtocol.swift
//  api-challenge
//
//  Created by Diogo Camargo on 21/08/25.
//


import SwiftUI

@MainActor
protocol OrdersVMProtocol: ObservableObject {
    var orderedProducts: [OrderProductDisplay] { get }
    var quantities: [Int: Int] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }

    func fetchOrderedProducts() async
    func quantity(for productId: Int) -> Int
}
