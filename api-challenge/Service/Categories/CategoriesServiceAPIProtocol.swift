//
//  CategoriesServiceAPIProtocol.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

protocol CategoriesServiceAPIProtocol {
    func fetchCategories() async throws -> [String]
}
