//
//  CartVMTests.swift
//  api-challenge
//
//  Created by Diogo Camargo on 22/08/25.
//


import XCTest
@testable import api_challenge
import SwiftData

@MainActor
final class CartVMTests: XCTestCase {
    
    // MARK: - Properties
    private var mockApiService: MockApiService!
    private var mockProductsService: MockUserProductService!
    private var viewModel: CartVM!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        mockApiService = MockApiService()
        mockProductsService = MockUserProductService()
        viewModel = CartVM(apiService: mockApiService, productsService: mockProductsService)
    }
    
    override func tearDown() {
        mockApiService = nil
        mockProductsService = nil
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    /// Testa o carregamento bem-sucedido do carrinho com produtos
    func testLoadCartSuccess() async {
        // Given
        // Adiciona produtos ao carrinho do mock
        let testDTO = ProductDTO(
            id: 1,
            title: "Test Product",
            description: "Test Description",
            category: "Test",
            price: 100.0,
            thumbnail: ""
        )
        
        do {
            try mockProductsService.addToCart(testDTO)
        } catch {
            XCTFail("Failed to add product to cart")
        }
        
        // When
        await viewModel.loadCart()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.cartProducts.count, 1)
        XCTAssertEqual(viewModel.cartProducts[0].product.id, 1)
        XCTAssertEqual(viewModel.cartProducts[0].product.quantity, 1)
    }
    
    /// Testa o carregamento do carrinho quando está vazio
    func testLoadCartEmptyCart() async {
        // Given - Carrinho vazio por padrão no mock
        
        // When
        await viewModel.loadCart()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.cartProducts.isEmpty)
    }
    
    /// Testa o tratamento de erro quando a API falha durante o carregamento do carrinho
    func testLoadCartApiError() async {
        // Given
        mockApiService.shouldFail = true
        
        // Adiciona um produto ao carrinho para tentar carregar
        let testDTO = ProductDTO(
            id: 1,
            title: "Test Product",
            description: "Test Description",
            category: "Test",
            price: 100.0,
            thumbnail: ""
        )
        
        do {
            try mockProductsService.addToCart(testDTO)
        } catch {
            XCTFail("Failed to add product to cart")
        }
        
        // When
        await viewModel.loadCart()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.cartProducts.isEmpty)
    }
    
    /// Testa o aumento bem-sucedido da quantidade de um produto no carrinho
    func testIncreaseQuantitySuccess() {
        // Given
        let testProduct = Product(id: 1, category: "Test")
        testProduct.isCart = true
        testProduct.quantity = 1
        mockProductsService.products.append(testProduct)
        
        // When
        viewModel.increaseQuantity(testProduct)
        
        // Then
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(testProduct.quantity, 2)
    }
    
    /// Testa a diminuição bem-sucedida da quantidade de um produto no carrinho
    func testDecreaseQuantitySuccess() {
        // Given
        let testProduct = Product(id: 1, category: "Test")
        testProduct.isCart = true
        testProduct.quantity = 2
        mockProductsService.products.append(testProduct)
        
        // When
        viewModel.decreaseQuantity(testProduct)
        
        // Then
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(testProduct.quantity, 1)
    }
    
    /// Testa a remoção do produto do carrinho quando a quantidade chega a zero
    func testDecreaseQuantityRemoveFromCart() {
        // Given
        let testProduct = Product(id: 1, category: "Test")
        testProduct.isCart = true
        testProduct.quantity = 1
        mockProductsService.products.append(testProduct)
        
        // When
        viewModel.decreaseQuantity(testProduct)
        
        // Then - Deve remover do carrinho quando quantidade chega a 0
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(testProduct.isCart)
        XCTAssertEqual(testProduct.quantity, 1) // Quantidade padrão após remoção
    }
    
    /// Testa o cálculo do preço total com múltiplos produtos no carrinho
    func testTotalPriceWithProducts() async {
        // Given
        // Adiciona produtos ao carrinho
        let testDTO1 = ProductDTO(
            id: 1,
            title: "Product 1",
            description: "Desc 1",
            category: "Test",
            price: 100.0,
            thumbnail: ""
        )
        
        let testDTO2 = ProductDTO(
            id: 2,
            title: "Product 2",
            description: "Desc 2",
            category: "Test",
            price: 200.0,
            thumbnail: ""
        )
        
        do {
            try mockProductsService.addToCart(testDTO1)
            try mockProductsService.addToCart(testDTO2)
            // Aumenta quantidade do primeiro produto
            if let product = mockProductsService.fetchProduct(by: 1) {
                try mockProductsService.increaseQuantity(product)
            }
        } catch {
            XCTFail("Failed to setup test products")
        }
        
        // When
        await viewModel.loadCart()
        let total = viewModel.totalPrice()
        
        // Then
        // Product 1: 100.0 * 2 = 200.0
        // Product 2: 200.0 * 1 = 200.0
        // Total: 400.0 (+ produtos inseridos no init)
        XCTAssertEqual(total, 559.97)
    }
    
    /// Testa o cálculo do preço total quando o carrinho está vazio
    func testTotalPriceEmptyCart() {
        // Given - Carrinho vazio
        
        // When
        let total = viewModel.totalPrice()
        
        // Then
        XCTAssertEqual(total, 0.0)
    }
    
    /// Testa o cálculo do preço total quando produtos não possuem DTO correspondente
    func testTotalPriceProductWithoutDTO() async {
        // Given
        // Adiciona produto diretamente sem DTO correspondente
        let testProduct = Product(id: 999, category: "Test") // ID que não existe no mock API
        testProduct.isCart = true
        testProduct.quantity = 2
        mockProductsService.products.append(testProduct)
        
        // When
        await viewModel.loadCart()
        let total = viewModel.totalPrice()
        
        // Then - Produtos sem DTO devem ser ignorados no cálculo
        XCTAssertEqual(total, 0.0)
    }
    
    /// Testa o processo de checkout bem-sucedido com produtos no carrinho
    func testCheckoutSuccess() async {
        // Given
        // Adiciona produtos ao carrinho
        let testDTO = ProductDTO(
            id: 1,
            title: "Test Product",
            description: "Test Description",
            category: "Test",
            price: 100.0,
            thumbnail: ""
        )
        
        do {
            try mockProductsService.addToCart(testDTO)
            await viewModel.loadCart() // Carrega primeiro para ter produtos no VM
        } catch {
            XCTFail("Failed to setup test")
        }
        
        // When
        await viewModel.checkout()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.checkoutSuccess)
        XCTAssertTrue(viewModel.cartProducts.isEmpty)
        XCTAssertNil(viewModel.errorMessage)
        
        // Verifica se os produtos foram movidos para pedidos
        let orderedProducts = mockProductsService.getOrderedProducts()
        XCTAssertEqual(orderedProducts.count, 1)
        XCTAssertTrue(orderedProducts[0].isOrder)
        XCTAssertFalse(orderedProducts[0].isCart)
    }
    
    /// Testa o processo de checkout quando o carrinho está vazio
    func testCheckoutEmptyCart() async {
        // Given - Carrinho vazio
        
        // When
        await viewModel.checkout()
        
        // Then - Deve funcionar mesmo com carrinho vazio
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.checkoutSuccess)
        XCTAssertTrue(viewModel.cartProducts.isEmpty)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    /// Testa o tratamento de erro durante o processo de checkout
    func testCheckoutError() async {
        // Given
        mockProductsService.shouldFailCheckout = true
        
        // Adiciona um produto ao carrinho primeiro
        let testDTO = ProductDTO(
            id: 1,
            title: "Test Product",
            description: "Test Description",
            category: "Test",
            price: 100.0,
            thumbnail: ""
        )
        
        do {
            try mockProductsService.addToCart(testDTO)
            await viewModel.loadCart() // Carrega os produtos
        } catch {
            XCTFail("Failed to setup test")
        }
        
        // When
        await viewModel.checkout()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.checkoutSuccess)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.errorMessage?.contains("Erro ao finalizar compra") == true)
        
        // Verifica que os produtos NÃO foram movidos para pedidos (devido ao erro)
        let orderedProducts = mockProductsService.getOrderedProducts()
        XCTAssertTrue(orderedProducts.isEmpty)
    }
    
    /// Testa se mensagens de erro são resetadas após operações bem-sucedidas
    func testErrorResetOnSuccessfulOperation() async {
        // Given - Configura um erro inicial
        viewModel.errorMessage = "Erro anterior"
        
        // When - Executa uma operação bem-sucedida
        await viewModel.loadCart() // Deve ser bem-sucedido com carrinho vazio
        
        // Then - O erro deve ser limpo
        XCTAssertNil(viewModel.errorMessage)
    }
}
