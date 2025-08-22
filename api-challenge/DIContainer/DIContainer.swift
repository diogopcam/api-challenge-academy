//
//  DIContainer.swift
//  api-challenge
//
//  Created by Diogo Camargo on 18/08/25.
//


// MARK: - DIContainer.swift
import SwiftData

@MainActor
final class DIContainer {
    let modelContainer: ModelContainer
    let userProductsService: any UserProductsServiceProtocol
    let apiService: any ApiServiceProtocol
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        self.userProductsService = UserProductsService(context: modelContainer.mainContext)
        self.apiService = ApiService()
    }
}
