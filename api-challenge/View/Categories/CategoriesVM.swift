//
//  HomeVM.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

import Foundation

@MainActor
final class CategoriesVM: CategoriesVMProtocol {
    var apiCategories: [String] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
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
