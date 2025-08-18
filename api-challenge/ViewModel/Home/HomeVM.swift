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
//    func persistProducts(_ products: [ProductDTO]) {
//        guard let context = modelContext else { return }
//
//        for dto in products {
//            // Verifica se o produto já existe
//            let descriptor = FetchDescriptor<Product>(predicate: #Predicate { $0.id == dto.id })
//            let existing = try? context.fetch(descriptor)
//
//            if existing?.isEmpty == false {
//                continue // já existe, não insere de novo
//            }
//
//            // Cria e insere novo produto
//            let newProduct = Product(
//                id: dto.id,
//                name: dto.title,
//                info: dto.description,
//                category: dto.category,
//                price: dto.price,
//                type: .none // <- Evita popular o carrinho acidentalmente
//            )
//            context.insert(newProduct)
//            print("Produto \(dto.title) adicionado no contexto")
//        }
//
//        do {
//            try context.save()
//            print("Todos os produtos foram salvos com sucesso!")
//        } catch {
//            print("Erro ao salvar produtos: \(error)")
//        }
//    }

    
    func persistProducts(_ products: [ProductDTO]) {
           guard let context = modelContext else { return }
   
        for dto in products {
            let dtoID = dto.id // <- capture fora

            let descriptor = FetchDescriptor<Product>(
                predicate: #Predicate { $0.id == dtoID } // use a constante capturada
            )

            let existing = try? context.fetch(descriptor)

            if existing?.isEmpty == false {
                continue // já existe, não insere de novo
            }

            let newProduct = Product(
                id: dto.id,
                name: dto.title,
                info: dto.description,
                category: dto.category,
                price: dto.price,
                type: .none
            )
            context.insert(newProduct)
        }
   
           do {
               try context.save()
               print("Todos os produtos foram salvos com sucesso!")
           } catch {
               print("Erro ao salvar produtos: \(error)")
           }
       }
}
