//
//  CategoriesServiceProtocol.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//


//
//  CategoriesServiceProtocol.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

protocol CategoriesServiceProtocol {
    func fetchCategories() async throws -> [String]
}
