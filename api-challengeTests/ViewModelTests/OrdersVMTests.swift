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
