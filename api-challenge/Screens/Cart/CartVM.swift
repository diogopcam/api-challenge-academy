//
//  CartVM.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 16/08/25.
//
import SwiftUI
import SwiftData

@MainActor
final class CartVM: CartVMProtocol {
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
            let dtoList = try await apiService.fetchProducts()
        
            productMap = Dictionary(uniqueKeysWithValues: dtoList.map { ($0.id, $0) })
            
            let cartItems = try productsService.getCartProducts()
            
            cartProducts = cartItems.map { product in
                let dto = productMap[product.id]
                return CartProductDisplay(product: product, dto: dto)
            }
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func increaseQuantity(_ product: Product) {
        do {
            try productsService.increaseQuantity(product)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func decreaseQuantity(_ product: Product) {
        do {
            try productsService.decreaseQuantity(product)
            
            if product.quantity == 0 {
                withAnimation(.easeInOut) {
                    cartProducts.removeAll { $0.product.id == product.id }
                }
            }
            
        } catch {
            print("Error: \(error)")
        }
    }

    
    func totalPrice() -> Double {
        var total: Double = 0.0
        
        for item in cartProducts {
            guard let dtoPrice = item.dto?.price else {
                continue
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
            
            cartProducts.removeAll()
            
        } catch {
            errorMessage = "Error to do checkout: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
