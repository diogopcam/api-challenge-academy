//
//  HomeVMTests.swift
//  api-challenge
//
//  Created by Your Name on 21/08/25.
//

import XCTest
@testable import api_challenge
import SwiftData

@MainActor
final class HomeVMTests: XCTestCase {
    
    var viewModel: HomeVM!
    var mockUserProductsService: MockUserProductService!
    var mockApiService: MockApiService!
    
    override func setUp() {
        super.setUp()
        mockUserProductsService = MockUserProductService()
        mockApiService = MockApiService()
        viewModel = HomeVM(apiService: mockApiService, productsService: mockUserProductsService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUserProductsService = nil
        mockApiService = nil
        super.tearDown()
    }
    
    // Testa se a ViewModel é inicializada corretamente com os serviços injetados e estados iniciais apropriados
    func testInitialization() {
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(viewModel.apiService)
        XCTAssertNotNil(viewModel.productsService)
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // Testa o carregamento bem-sucedido de produtos da API, verificando estados de loading e dados
    func testLoadProductsSuccess() async {
        mockApiService.shouldFail = false
        
        await viewModel.loadProducts()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.products.count, 2)
        XCTAssertEqual(viewModel.products.first?.id, 1)
        XCTAssertEqual(viewModel.products.last?.id, 2)
    }
    
    // Testa o comportamento quando a API falha ao carregar produtos, verificando a mensagem de erro
    func testLoadProductsWithApiFailure() async {
        mockApiService.shouldFail = true
        
        await viewModel.loadProducts()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.products.isEmpty)
    }
    
    // Testa a verificação de produto favorito para um produto que está marcado como favorito
    func testIsProductFavoriteReturnsTrue() {
        let favoriteProduct = Product(id: 1, category: "Favorites")
        favoriteProduct.isFavorite = true
        mockUserProductsService.products = [favoriteProduct]
        
        let isFavorite = viewModel.isProductFavorite(id: 1)
        
        XCTAssertTrue(isFavorite)
    }
    
    // Testa a verificação de produto favorito para um produto que não está marcado como favorito
    func testIsProductFavoriteReturnsFalse() {
        let nonFavoriteProduct = Product(id: 2, category: "Electronics")
        nonFavoriteProduct.isFavorite = false
        mockUserProductsService.products = [nonFavoriteProduct]
        
        let isFavorite = viewModel.isProductFavorite(id: 2)
        
        XCTAssertFalse(isFavorite)
    }
    
    // Testa a verificação de produto favorito para um produto que não existe no serviço
    func testIsProductFavoriteForNonExistentProduct() {
        let isFavorite = viewModel.isProductFavorite(id: 999)
        
        XCTAssertFalse(isFavorite)
    }
    
    // Testa a alternância de favorito para desmarcar um produto como favorito
    func testToggleFavoriteUnmarksProductAsFavorite() {
        let favoriteProduct = Product(id: 1, category: "Favorites")
        favoriteProduct.isFavorite = true
        mockUserProductsService.products = [favoriteProduct]
        
        let productDTO = ProductDTO(id: 1, title: "Test Product", description: "Test", category: "Favorites", price: 100, thumbnail: "")
        
        viewModel.toggleFavorite(for: productDTO)
        let isFavorite = viewModel.isProductFavorite(id: 1)
        
        XCTAssertFalse(isFavorite)
    }
    
    // Testa que o estado de loading sempre retorna para false após a conclusão do carregamento, mesmo em caso de falha
    func testLoadingStateIsAlwaysFalseAfterLoad() async {
        mockApiService.shouldFail = false
        
        await viewModel.loadProducts()
        XCTAssertFalse(viewModel.isLoading)
        
        mockApiService.shouldFail = true
        await viewModel.loadProducts()
        XCTAssertFalse(viewModel.isLoading)
    }
}
