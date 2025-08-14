//
//  HomeViewModel.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

import Foundation

@Observable
class CategoriesVM: CategoriesVMProtocol {
    var categories: [String] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let service: CategoriesServiceProtocol
    
    init(service: CategoriesServiceProtocol = CategoriesService()) {
        self.service = service
    }
    
    func loadCategories() async {
        isLoading = true
        errorMessage = nil
        
        do {
            categories = try await service.fetchCategories()
        } catch {
            errorMessage = "Error to fetch Categories: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
