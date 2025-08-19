//
//  HomeVM.swift
//  api-challenge
//
//  Created by Diogo Camargo on 15/08/25.
//

import SwiftUI
import SwiftData

@MainActor
final class HomeVM: ObservableObject {
    @Published var products: [ProductDTO] = []    // Adicione @Published
    @Published var isLoading = false             // Adicione @Published
    @Published var errorMessage: String?
   
    private let apiService: any ProductsServiceProtocolAPI
    public var modelContext: ModelContext?
    
    init(apiService: any ProductsServiceProtocolAPI) {
        self.apiService = apiService
    }
    
    @MainActor
    func loadProducts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            products = try await apiService.fetchProducts()
            try persistProducts(products) // persistindo no banco
        } catch {
            errorMessage = error.localizedDescription
            print("Error loading products: \(error)")
        }
        
        isLoading = false
    }
    
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
                type: .none,
                thumbnail: dto.thumbnail
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
