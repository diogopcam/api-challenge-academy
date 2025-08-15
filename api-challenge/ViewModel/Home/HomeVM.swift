//
//  HomeViewModel.swift
//  api-challenge
//
//  Created by Diogo Camargo on 15/08/25.
//

import SwiftUI
import SwiftData

@Observable
final class HomeVM {
    var products: [ProductDTO] = []
    var isLoading = false
    var errorMessage: String?
    private let service: ProductsServiceProtocol
    public var modelContext: ModelContext?

    
    init(service: ProductsServiceProtocol = ProductsService()) {
        self.service = service
    }
    
    @MainActor
    func loadProducts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            products = try await service.fetchProducts()
            try persistProducts(products) // persistindo no banco
        } catch {
            errorMessage = error.localizedDescription
            print("Error loading products: \(error)")
        }
        
        isLoading = false
    }
    
    // Função de persistência
    func persistProducts(_ products: [ProductDTO]) {
        guard let context = modelContext else { return }

        for dto in products {
            let newProduct = Product(
                name: dto.title,
                info: dto.description,
                category: dto.category,
                price: dto.price,
                type: ProductType.cart
            )
            context.insert(newProduct)
            print("Produto \(dto.title) adicionado no contexto")
        }

        do {
            try context.save()
            print("Todos os produtos foram salvos com sucesso!")
        } catch {
            print("Erro ao salvar produtos: \(error)")
        }
    }

}
