//
//  OrdersVM.swift
//  api-challenge
//
//  Created by Diogo Camargo on 18/08/25.
//

import SwiftUI
import SwiftData


@MainActor
final class OrdersVM: ObservableObject {
    @Published var orderedProducts: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service: any UserProductsServiceProtocol
    
    init(service: any UserProductsServiceProtocol) {
        self.service = service
        fetchOrderedProducts()
        self.service.printAllProducts()
    }
    
    
    func fetchOrderedProducts() {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            orderedProducts = service.getOrderedProducts()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
