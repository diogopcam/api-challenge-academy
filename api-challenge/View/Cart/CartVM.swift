//
//  CartVM.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 16/08/25.
//

import SwiftUI
import SwiftData

@MainActor
final class CartVM: ObservableObject {
    @Published var cartProducts: [CartProductDisplay] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var checkoutSuccess = false
    
    private let productsService: any UserProductsServiceProtocol
    private let apiService: ApiServiceProtocol
    private var productMap: [Int: ProductDTO] = [:]
    
    init(apiService: any ApiServiceProtocol, productsService: any UserProductsServiceProtocol) {
        self.apiService = apiService
        self.productsService = productsService
    }
    
    func loadCart() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Pega dados da API
            let dtoList = try await apiService.fetchProducts()
            productMap = Dictionary(uniqueKeysWithValues: dtoList.map { ($0.id, $0) })
            
            // Pega dados do carrinho do SwiftData
            let cartItems = try productsService.getCartProducts()
            
            // Mapeia para display
            cartProducts = cartItems.map { product in
                let dto = productMap[product.id]
                return CartProductDisplay(product: product, dto: dto)
            }
            
            // Print para debug
            print("=== PRODUTOS NO CARRINHO ===")
            for product in cartItems {
                print("ID: \(product.id), Quantidade: \(product.quantity)")
            }
            print("Total de itens: \(cartItems.count)")
            
        } catch {
            errorMessage = error.localizedDescription
            print("Erro ao carregar carrinho: \(error)")
        }
        
        isLoading = false
    }
    
    func increaseQuantity(_ product: Product) {
        do {
            try productsService.increaseQuantity(product)
        } catch {
            errorMessage = "Erro ao aumentar quantidade"
            print("Erro: \(error)")
        }
    }
    
    func decreaseQuantity(_ product: Product) {
        do {
            try productsService.decreaseQuantity(product)
        } catch {
            errorMessage = "Erro ao diminuir quantidade"
            print("Erro: \(error)")
        }
    }
    
    
    func totalPrice() -> Double {
        var total: Double = 0.0
        
        for item in cartProducts {
            // Força o uso do DTO (dado atualizado)
            guard let dtoPrice = item.dto?.price else {
                continue // Pula itens sem DTO (ou trata como 0)
            }
            total += dtoPrice * Double(item.product.quantity)
        }
        
        return total
    }
    
    func checkout() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try productsService.checkoutCartProducts()
            checkoutSuccess = true
            
            // Limpa o carrinho localmente
            cartProducts.removeAll()
            
            print("Checkout realizado com sucesso!")
            
        } catch {
            errorMessage = "Erro ao finalizar compra: \(error.localizedDescription)"
            print("Erro no checkout: \(error)")
        }
        
        isLoading = false
    }
}
