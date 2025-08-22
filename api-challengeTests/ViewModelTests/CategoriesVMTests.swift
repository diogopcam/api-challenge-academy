//
//  CategoriesVMTests.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 22/08/25.
//

import XCTest
@testable import api_challenge


class CategoriesVMTests: XCTestCase {
    
    @MainActor func testLoadCategories() async {
        //Given
        let apiService = MockApiService()
         
        let viewModel = CategoriesVM (apiService: apiService)
        
        //when
        await viewModel.loadCategories()
        
        //then
        XCTAssertTrue(!viewModel.apiCategories.isEmpty)
        
    }
    
    
    @MainActor func testLoadCategoriesFails() async {
        //Given
        let apiService = MockApiService(shouldFail: true)
         
        let viewModel = CategoriesVM (apiService: apiService)
        
        //when
        await viewModel.loadCategories()
        
        //then
        XCTAssertTrue(viewModel.apiCategories.isEmpty)
        
        
    }
    
    
}
