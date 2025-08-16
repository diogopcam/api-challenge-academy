//
//  HomeView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//


import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) public var modelContext
    @State private var viewModel = HomeVM()
    
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
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    } else if let errorMessage = viewModel.errorMessage {
                        ErrorView(message: errorMessage) {
                            Task { await viewModel.loadProducts() }
                        }
                        .padding()
                    } else {
                        // Primeiro produto em destaque
                        if let firstProduct = viewModel.products.first {
                            ProductCardH(product: firstProduct)
                                .padding(.horizontal)
                        }
                        
                        // Produtos restantes
                        let remainingProducts = Array(viewModel.products.dropFirst())
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
                                    ProductCardV(product: product)
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
                await viewModel.loadProducts()
            }
        }
        .task {
            viewModel.modelContext = modelContext
            await viewModel.loadProducts()
        }
    }
}

#Preview {
    TabBar()
}
