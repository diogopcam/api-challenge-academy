//
//  ProductDetailsVMTests.swift
//  api-challenge
//
//  Created by Diogo Camargo on 21/08/25.
//


//
//  ProductDetailsVMTests.swift
//  api-challenge
//
//  Created by Your Name on 21/08/25.
//

import XCTest
@testable import api_challenge

@MainActor
final class ProductDetailsVMTests: XCTestCase {
    
    var viewModel: ProductDetailsVM!
    var mockUserProductsService: MockUserProductService!
    var mockApiService: MockApiService!
    var sampleProduct: ProductDTO!
    
    override func setUp() {
        super.setUp()
        mockUserProductsService = MockUserProductService()
        mockApiService = MockApiService()
        sampleProduct = ProductDTO(id: 1, title: "Test Product", description: "Test Description", category: "Favorites", price: 99.99, thumbnail: "")
        viewModel = ProductDetailsVM(product: sampleProduct, apiService: mockApiService, productsService: mockUserProductsService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUserProductsService = nil
        mockApiService = nil
        sampleProduct = nil
        super.tearDown()
    }
    
    // Testa se a ViewModel é inicializada corretamente com o produto e serviços injetados
    func testInitialization() {
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(viewModel.apiService)
        XCTAssertNotNil(viewModel.productsService)
        XCTAssertEqual(viewModel.product.id, 1)
        XCTAssertEqual(viewModel.product.title, "Test Product")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // Testa a adição bem-sucedida de um produto ao carrinho
    func testAddToCartSuccess() {
        viewModel.addToCart()
        
        XCTAssertNil(viewModel.errorMessage)
        
        let cartProducts = try? mockUserProductsService.getCartProducts()
        XCTAssertEqual(cartProducts?.count, 1)
        XCTAssertEqual(cartProducts?.first?.id, 1)
    }
    
    // Testa a verificação de produto favorito para um produto marcado como favorito
    func testIsProductFavoriteReturnsTrue() {
        let favoriteProduct = Product(id: 1, category: "Favorites")
        favoriteProduct.isFavorite = true
        mockUserProductsService.products = [favoriteProduct]
        
        let isFavorite = viewModel.isProductFavorite(id: 1)
        
        XCTAssertTrue(isFavorite)
    }
    
    // Testa a verificação de produto favorito para um produto não marcado como favorito
    func testIsProductFavoriteReturnsFalse() {
        let nonFavoriteProduct = Product(id: 1, category: "Favorites")
        nonFavoriteProduct.isFavorite = false
        mockUserProductsService.products = [nonFavoriteProduct]
        
        let isFavorite = viewModel.isProductFavorite(id: 1)
        
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
        
        viewModel.toggleFavorite(for: sampleProduct)
        let isFavorite = viewModel.isProductFavorite(id: 1)
        
        XCTAssertFalse(isFavorite)
    }
    
    // Testa que a ViewModel mantém o estado de loading como false após operações
    func testLoadingStateRemainsFalseAfterOperations() {
        XCTAssertFalse(viewModel.isLoading)
        
        viewModel.addToCart()
        XCTAssertFalse(viewModel.isLoading)
        
        viewModel.toggleFavorite(for: sampleProduct)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    // Testa a inicialização com um produto diferente
    func testInitializationWithDifferentProduct() {
        let differentProduct = ProductDTO(id: 2, title: "Different Product", description: "Different", category: "Electronics", price: 199.99, thumbnail: "")
        let differentViewModel = ProductDetailsVM(product: differentProduct, apiService: mockApiService, productsService: mockUserProductsService)
        
        XCTAssertEqual(differentViewModel.product.id, 2)
        XCTAssertEqual(differentViewModel.product.title, "Different Product")
        XCTAssertEqual(differentViewModel.product.category, "Electronics")
    }
}
