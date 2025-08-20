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
    @Published var orderedProducts: [ProductDTO] = []
    @Published var quantities: [Int: Int] = [:]
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiService: any ApiServiceProtocol
    private let userService: any UserProductsServiceProtocol
    
    // ✅ Corrige o init - não deve ser async
    init(apiService: any ApiServiceProtocol, service: any UserProductsServiceProtocol) {
        self.apiService = apiService
        self.userService = service
    }
    
    func fetchOrderedProducts() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false } // Garante que isLoading será false
        
        do {
            // 1. Pega produtos pedidos (persistência)
            let persistedOrders = userService.getOrderedProducts()
            
            // 2. Limpa dados anteriores
            orderedProducts.removeAll()
            quantities.removeAll()
            
            // 3. Busca dados atualizados da API EM PARALELO
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
                
                // 4. Processa resultados
                for await result in group {
                    if let (productDTO, quantity) = result {
                        await MainActor.run {
                            self.orderedProducts.append(productDTO)
                            self.quantities[productDTO.id] = quantity
                        }
                    }
                }
            }
            
            print("✅ \(orderedProducts.count) produtos carregados")
            
        } catch {
            errorMessage = "Erro ao carregar pedidos: \(error.localizedDescription)"
        }
    }
    
    func quantity(for productId: Int) -> Int {
        quantities[productId] ?? 1
    }
}
