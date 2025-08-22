//
//  HomeVM.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

import Foundation

@MainActor
final class CategoriesVM: CategoriesVMProtocol {
    @Published var apiCategories: [String] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let service: ApiServiceProtocol
    
    init(apiService: any ApiServiceProtocol) {
        self.service = apiService
    }
    
    func loadCategories() async {
        isLoading = true
        errorMessage = nil
        
        do {
            apiCategories = try await service.fetchCategories()
        } catch {
            errorMessage = "Error to fetch Categories: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
