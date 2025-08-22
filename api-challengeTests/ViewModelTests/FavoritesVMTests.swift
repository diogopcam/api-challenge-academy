//
//  FavoritesViewModelTests.swift
//  api-challengeTests
//
//  Created by Eduardo Ferrari on 20/08/25.
//


import XCTest
@testable import api_challenge

@MainActor
class FavoritesVMTests: XCTestCase  {

    func testFetchFavorites() async throws {
           //Given
            let apiService = MockApiService()
            let userService = MockUserProductService()
            
            let viewModel = FavoritesVM(apiService: apiService, productsService: userService)
            
           //When
            await viewModel.loadFavorites()
            viewModel.filterFavorites(by: "test")
        
            
           //Then
            XCTAssertTrue(!viewModel.favoriteProducts.isEmpty)

        }
    
    func testTogleFavorites() async throws {
            //Given
            let apiService = MockApiService()
            let userService = MockUserProductService()
             
        let viewModel = FavoritesVM(apiService: apiService, productsService: userService)
            let productDTO: ProductDTO = .init(id: 5, title: "Test", description: "Test", category: "Test", price: 10.0, thumbnail: "Test")
            
            //When
            viewModel.toggleFavorite(productDTO)
        
            //Then
            XCTAssertTrue(viewModel.productsService.isProductFavorite(id: 5))
        
        }
    
    func testAddToCartFavorites() async throws {
        //Given
        let apiService = MockApiService()
        let userService = MockUserProductService()
        
        let viewModel = await FavoritesVM(apiService: apiService, productsService: userService)
        let productDTO: ProductDTO = .init(id: 5, title: "Test", description: "Test", category: "Test", price: 10.0, thumbnail: "Test")
        
        //When
        await viewModel.addToCart(productDTO)
        
        //Then
        XCTAssertNotNil(userService.fetchProduct(by: 5))
        
        let product = userService.fetchProduct(by: 5)
        XCTAssertTrue(((product?.isCart) != nil && (product?.isCart == true)))
    }
    
    //Fails
    func testFetchFavoritesFails() async throws {
           //Given
            let apiService = MockApiService(shouldFail: true)
            let userService = MockUserProductService()
            
        let viewModel = FavoritesVM(apiService: apiService, productsService: userService)
            
           //When
            await viewModel.loadFavorites()
            viewModel.filterFavorites(by: "")
        
            
           //Then
            XCTAssertTrue(viewModel.favoriteProducts.isEmpty)
            XCTAssertTrue(viewModel.filteredProducts.isEmpty && viewModel.favoriteProducts.isEmpty)
        }
    
    func testTogleFavoritesFails() async throws {
            //Given
            let apiService = MockApiService(shouldFail: true)
            let userService = MockUserProductService()
             
        let viewModel = FavoritesVM(apiService: apiService, productsService: userService)
            let productDTO: ProductDTO = .init(id: -1, title: "Test", description: "Test", category: "Test", price: 10.0, thumbnail: "Test")
        
            
            //When
            viewModel.toggleFavorite(productDTO)
        
            //Then
            XCTAssertTrue(viewModel.errorMessage != nil)
        }

    func testAddToCartFavoritesFails() async throws {
        //Given
        let apiService = MockApiService()
        let userService = MockUserProductService()
        
        let viewModel = FavoritesVM(apiService: apiService, productsService: userService)
        let productDTO: ProductDTO = .init(id: -1, title: "Test", description: "Test", category: "Test", price: 10.0, thumbnail: "Test")
        
        //When
        viewModel.addToCart(productDTO)
        
        //Then
        XCTAssertTrue(viewModel.errorMessage != nil)
    }
}
