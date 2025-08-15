//
//  CategoriesViewModelProtocol.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//


//
//  CategoriesViewModelProtocol.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

import Foundation

protocol CategoriesVMProtocol {
    var apiCategories: [String] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func loadCategories() async
}

