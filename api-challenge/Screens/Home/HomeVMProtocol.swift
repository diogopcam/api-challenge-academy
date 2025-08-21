//
//  HomeVMProtocol.swift
//  api-challenge
//
//  Created by Diogo Camargo on 15/08/25.
//
import SwiftUI

@MainActor
protocol HomeVMProtocol: ObservableObject {
    var products: [ProductDTO] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func loadProducts() async
}

