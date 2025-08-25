//
//  HomeView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//
import SwiftUI
import SwiftData

struct HomeView: View {

    @StateObject private var vm: HomeVM
    @State private var searchText = ""
    @State private var selectedProduct: ProductDTO? = nil
    @State private var showProductDetails = false
    
    init(vm: HomeVM) {  // Recebe a VM já configurada
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Título principal
                    Text("Deals of the Day")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                        .padding(.top, 16)
                    
                    if vm.isLoading {
                        ProgressView()
                            .padding()
                    } else if let errorMessage = vm.errorMessage {
                        ErrorView(message: errorMessage) {
                            Task { await vm.loadProducts() }
                        }
                        .padding()
                    } else {
                        // Primeiro produto em destaque
                        if let firstProduct = vm.products.first {
                            ProductCardH(
                                product: firstProduct,
                                isFavorited: vm.isProductFavorite(id: firstProduct.id),
                                onToggleFavorite: {
                                    vm.toggleFavorite(for: firstProduct)
                                },
                                onTapProduct: { openSheet(product: firstProduct) }
                            )
                            .padding(.horizontal)
                        }
                        
                        // Produtos restantes
                        let remainingProducts = Array(vm.products.dropFirst())
                        if !remainingProducts.isEmpty {
                            Text("Top Picks")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                                .padding(.top, 16)
                            
                            let columns = [
                                GridItem(.flexible(), spacing: 0),
                                GridItem(.flexible(), spacing: 0)
                            ]
                            
                            LazyVGrid(columns: columns, spacing: 8) {
                                ForEach(remainingProducts, id: \.id) { product in
                                    ProductCardV(
                                        product: product,
                                        isFavorited: vm.isProductFavorite(id: product.id),
                                        onToggleFavorite: { vm.toggleFavorite(for: product) }, onTapProduct: { openSheet(product: product) }
                                    )
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.top, -12)
                        }
                    }
                }
            }
            .navigationTitle("Home")
            .background(.backgroundsPrimary)
            .refreshable {
                await vm.loadProducts()
            }
        }
        .task {
            await vm.loadProducts()
        }
        .sheet(item: $selectedProduct) { product in
            ProductDetailsSheet(
                vm: ProductDetailsVM(
                    product: product, // <- aqui usamos o `product` recebido do sheet
                    apiService: vm.apiService,
                    productsService: vm.productsService
                )
            )
        }
    }
    
    private func openSheet(product: ProductDTO) {
        selectedProduct = product
    }
}

#Preview {
    TabBar()
}
