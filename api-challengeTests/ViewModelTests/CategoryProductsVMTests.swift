//
//  CategoryProductsVM.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 21/08/25.
//

import XCTest
@testable import api_challenge

class CategoryProductsVMTests: XCTestCase {
    
    
    @MainActor func testLoadProducts() async {
        //Given
         let apiService = MockApiService()
         let userService = MockUserProductService()
         
        let viewModel = CategoryProductsVM (categoryName: "Favorites",apiService: apiService, productsService: userService)
        
        //when
        await viewModel.loadProducts()
        
        //then
        XCTAssertTrue(!viewModel.products.isEmpty)
        
    }
    
    @MainActor func testIsProductFavorite() async {
        //Given
         let apiService = MockApiService()
         let userService = MockUserProductService()
         
        let viewModel = CategoryProductsVM (categoryName: "Favorites",apiService: apiService, productsService: userService)
       
        
        
        //When
        await viewModel.loadProducts()
        
        
        //Then
        XCTAssertTrue(viewModel.isProductFavorite(id: 1))
        
        
    }
    
    @MainActor func testToggleFavorite() async {
        //Given
         let apiService = MockApiService()
         let userService = MockUserProductService()
         
        let viewModel = CategoryProductsVM (categoryName: "Favorites",apiService: apiService, productsService: userService)
       
        
        
        //When
        await viewModel.loadProducts()
        let productDTO: ProductDTO = .init(id: 5, title: "Test", description: "Test", category: "Test", price: 10.0, thumbnail: "Test")
        viewModel.toggleFavorite(for: productDTO)
        
        let isTrue = userService.fetchProduct(by: 5)?.isFavorite
        
        
        //Then
        XCTAssertTrue((isTrue != nil) && isTrue == true)
        
    }
    
}
