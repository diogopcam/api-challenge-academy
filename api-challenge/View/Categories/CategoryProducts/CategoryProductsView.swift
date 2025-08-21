////
////  Category1View.swift
////  api-challenge
////
////  Created by Eduardo Ferrari on 15/08/25.
////

import SwiftUI
import SwiftData

struct CategoryProductsView: View {
    
    @State private var searchText = ""
    @State private var selectedProduct: ProductDTO? = nil
    @StateObject private var vm: CategoryProductsVM
    @State private var sheetDismissed = false
    @State private var refreshFlag = false // Flag para forçar atualização
    
    let categoryName: String
    
    var formattedCategoryName: String {
        CategoryFormatter(apiValue: categoryName).formattedName
    }
    
    init(vm: CategoryProductsVM){
        _vm = StateObject(wrappedValue: vm)
        categoryName = vm.categoryName
    }
    
    var filteredProducts: [ProductDTO] {
        if searchText.isEmpty {
            return vm.products
        } else {
            return vm.products.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24){
                    if vm.isLoading {
                        ProgressView()
                            .padding()
                    } else if let errorMessage = vm.errorMessage {
                        ErrorView(message: errorMessage) {
                            Task { await vm.loadProducts() }
                        }
                        .padding()
                    } else if !vm.products.isEmpty {
                        // Grid de produtos
                        let columns = [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ]
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(vm.products, id: \.id) { product in
                                ProductCardV(
                                    product: product,
                                    isFavorited: vm.isProductFavorite(id: product.id),
                                    onToggleFavorite: { vm.toggleFavorite(for: product) },
                                    onTapProduct: { openSheet(product: product) }
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    } else {
                        // Estado vazio
                        VStack {
                            Text("No products found")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                    }
                }
            }
            .navigationTitle(formattedCategoryName)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search...")
        }

        .task {
            await vm.loadProducts() // carrega produtos da categoria
        }
        .task(id: sheetDismissed) {
            // Atualiza quando a sheet é fechada
            if sheetDismissed {
                await vm.loadProducts() // ou vm.refreshFavorites() se tiver esse método
                sheetDismissed = false
            }
        }
        .sheet(item: $selectedProduct) { product in
            ProductDetailsSheet(
                vm: ProductDetailsVM(
                    product: product,
                    apiService: vm.apiService,
                    productsService: vm.productsService
                )
            )
            .onDisappear {
                vm.objectWillChange.send()
            }
        }
    }
    
    private func openSheet(product: ProductDTO) {
        selectedProduct = product
    }
}

