//
//  OrdersVM.swift
//  api-challenge
//
//  Created by Diogo Camargo on 18/08/25.
//

import SwiftUI
import SwiftData

@MainActor
final class OrdersVM: OrdersVMProtocol {
    @Published var orderedProducts: [ProductDTO] = []
    @Published var quantities: [Int: Int] = [:]
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let apiService: any ApiServiceProtocol
    let userService: any UserProductsServiceProtocol
    
    init(apiService: any ApiServiceProtocol, service: any UserProductsServiceProtocol) {
        self.apiService = apiService
        self.userService = service
    }
    
    func fetchOrderedProducts() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        let persistedOrders = userService.getOrderedProducts()
        orderedProducts.removeAll()
        quantities.removeAll()
        
        var failedProducts: Int = 0
        
        await withTaskGroup(of: (ProductDTO, Int)?.self) { group in
            for persistedProduct in persistedOrders {
                group.addTask {
                    do {
                        let productDTO = try await self.apiService.fetchProduct(id: persistedProduct.id)
                        return (productDTO, persistedProduct.quantity)
                    } catch {
                        print("Erro ao buscar produto \(persistedProduct.id): \(error)")
                        return nil
                    }
                }
            }
            
            for await result in group {
                if let (productDTO, quantity) = result {
                    await MainActor.run {
                        self.orderedProducts.append(productDTO)
                        self.quantities[productDTO.id] = quantity
                    }
                } else {
                    failedProducts += 1
                }
            }
        }
        
        if failedProducts > 0 {
            if orderedProducts.isEmpty {
                errorMessage = "Não foi possível carregar seus pedidos. Verifique sua conexão."
            } else {
                errorMessage = "\(failedProducts) pedido(s) não puderam ser carregados."
            }
        }
        
        print("✅ \(orderedProducts.count) produtos carregados, \(failedProducts) falhas")
    }
    
    func quantity(for productId: Int) -> Int {
        quantities[productId] ?? 1
    }
}
