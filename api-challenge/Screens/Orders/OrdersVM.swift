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
    @Published var orderedProducts: [OrderProductDisplay] = []
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
           var tempOrdered: [OrderProductDisplay] = []

           await withTaskGroup(of: OrderProductDisplay?.self) { group in
               for persisted in persistedOrders {
                   group.addTask {
                       do {
                           let dto = try await self.apiService.fetchProduct(id: persisted.id)
                           return OrderProductDisplay(
                               product: dto,
                               quantity: persisted.quantity,
                               dateOrdered: persisted.dateOrdered ?? Date()
                           )
                       } catch {
                           print("Erro ao buscar produto \(persisted.id): \(error)")
                           return nil
                       }
                   }
               }

               for await result in group {
                   if let display = result {
                       tempOrdered.append(display)
                   }
               }
           }

           // Atualiza a lista com animação
           withAnimation(.easeInOut) {
               self.orderedProducts = tempOrdered
           }
       }
    
    func quantity(for productId: Int) -> Int {
        quantities[productId] ?? 1
    }
}
