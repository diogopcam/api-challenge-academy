//
//  OrdersVMTests.swift
//  api-challenge
//
//  Created by Diogo Camargo on 21/08/25.
//

import XCTest
@testable import api_challenge
import SwiftData

@MainActor
final class OrdersVMTests: XCTestCase {
    
    var viewModel: OrdersVM!
    var mockUserProductsService: MockUserProductService!
    var mockApiService: MockApiService!
    
    override func setUp() {
        super.setUp()
        mockUserProductsService = MockUserProductService()
        mockApiService = MockApiService()
        viewModel = OrdersVM(apiService: mockApiService, service: mockUserProductsService)
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
        XCTAssertNotNil(viewModel.userService)
        XCTAssertTrue(viewModel.orderedProducts.isEmpty)
        XCTAssertTrue(viewModel.quantities.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // Testa o cenário de sucesso onde múltiplos produtos pedidos são carregados com sucesso da API
    func testFetchOrderedProductsSuccess() async {
        let orderedProduct1 = Product(id: 1, category: "Favorites")
        orderedProduct1.isOrder = true
        orderedProduct1.quantity = 2
        
        let orderedProduct2 = Product(id: 2, category: "Electronics")
        orderedProduct2.isOrder = true
        orderedProduct2.quantity = 1
        
        mockUserProductsService.products = [orderedProduct1, orderedProduct2]
        
        await viewModel.fetchOrderedProducts()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.orderedProducts.count, 2)
        XCTAssertEqual(viewModel.quantities.count, 2)
        XCTAssertEqual(viewModel.quantities[1], 2)
        XCTAssertEqual(viewModel.quantities[2], 1)
        
        let product1 = viewModel.orderedProducts.first(where: { $0.id == 1 })
        let product2 = viewModel.orderedProducts.first(where: { $0.id == 2 })
        
        XCTAssertNotNil(product1)
        XCTAssertNotNil(product2)
        XCTAssertEqual(product1?.title, "Test Product 1")
        XCTAssertEqual(product2?.title, "Test Product 2")
    }
    
    // Testa o cenário onde não existem produtos pedidos, garantindo que os arrays permanecem vazios
    func testFetchOrderedProductsEmpty() async {
        mockUserProductsService.products = []
        
        await viewModel.fetchOrderedProducts()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.orderedProducts.isEmpty)
        XCTAssertTrue(viewModel.quantities.isEmpty)
    }
    
    // Testa o cenário onde todos os produtos falham ao ser carregados da API, verificando a mensagem de erro
    func testFetchOrderedProductsWithAllProductsFailing() async {
        let orderedProduct = Product(id: 1, category: "Favorites")
        orderedProduct.isOrder = true
        mockUserProductsService.products = [orderedProduct]
        mockApiService.shouldFail = true
        
        await viewModel.fetchOrderedProducts()
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.orderedProducts.isEmpty)
    }

    // Testa o cenário onde alguns produtos falham mas outros são carregados com sucesso
    func testFetchOrderedProductsWithSomeProductsFailing() async {
        let workingProduct = Product(id: 1, category: "Favorites")
        workingProduct.isOrder = true
        
        let failingProduct = Product(id: 999, category: "Favorites")
        failingProduct.isOrder = true
        
        mockUserProductsService.products = [workingProduct, failingProduct]
        
        await viewModel.fetchOrderedProducts()
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.orderedProducts.count, 1)
        XCTAssertEqual(viewModel.quantities.count, 1)
    }
    
    // Testa a recuperação da quantidade correta para um produto existente no dicionário de quantidades
    func testQuantityForExistingProduct() async {
        let orderedProduct = Product(id: 1, category: "Favorites")
        orderedProduct.isOrder = true
        orderedProduct.quantity = 3
        mockUserProductsService.products = [orderedProduct]
        
        await viewModel.fetchOrderedProducts()
        
        let quantity = viewModel.quantity(for: 1)
        
        XCTAssertEqual(quantity, 3)
    }
    
    // Testa o retorno da quantidade padrão (1) para um produto que não existe no dicionário de quantidades
    func testQuantityForNonExistingProduct() {
        let quantity = viewModel.quantity(for: 999)
        
        XCTAssertEqual(quantity, 1)
    }
    
    // Testa o retorno da quantidade padrão quando o fetch de produtos falha completamente
    func testQuantityAfterFailedFetch() async {
        let orderedProduct = Product(id: 1, category: "Favorites")
        orderedProduct.isOrder = true
        orderedProduct.quantity = 3
        mockUserProductsService.products = [orderedProduct]
        mockApiService.shouldFail = true
        
        await viewModel.fetchOrderedProducts()
        
        let quantity = viewModel.quantity(for: 1)
        
        XCTAssertEqual(quantity, 1)
    }
    
    // Testa que o estado de loading sempre retorna para false após a conclusão do fetch, independente de sucesso ou falha
    func testLoadingStateIsAlwaysFalseAfterFetch() async {
        let orderedProduct = Product(id: 1, category: "Favorites")
        orderedProduct.isOrder = true
        mockUserProductsService.products = [orderedProduct]
        
        await viewModel.fetchOrderedProducts()
        XCTAssertFalse(viewModel.isLoading)
        
        mockApiService.shouldFail = true
        await viewModel.fetchOrderedProducts()
        XCTAssertFalse(viewModel.isLoading)
    }
}
