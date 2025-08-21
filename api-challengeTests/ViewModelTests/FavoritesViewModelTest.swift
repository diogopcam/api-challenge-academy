//
//  FavoritesViewModelTests.swift
//  api-challengeTests
//
//  Created by Eduardo Ferrari on 20/08/25.
//

import XCTest
@testable import api_challenge

class FavoritesViewModelTest: XCTestCase  {


//
//        override func setUpWithError() throws {
//            // Put setup code here. This method is called before the invocation of each test method in the class.
//        }
//
//        override func tearDownWithError() throws {
//            // Put teardown code here. This method is called after the invocation of each test method in the class.
//        }
    
    @MainActor func testFetchFavorites() async throws {
           //Given
            let apiService = MockApiService()
            let userService = MockUserProductService()
            
        let viewModel = FavoritesVM(apiService: apiService, productsService: userService)
            
           //When
            await viewModel.loadFavorites()
        
            
           //Then
            XCTAssertTrue(!viewModel.favoriteProducts.isEmpty)
           
        }
    
    @MainActor func testTogleFavorites() async throws {
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
//        func testPerformanceExample() throws {
//            // This is an example of a performance test case.
//            measure {
//                // Put the code you want to measure the time of here.
//            }
//        }
}
