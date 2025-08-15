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

//    init() {
//        _viewModel = State(initialValue: HomeVM(modelContext: modelContext))
//    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Título ou destaque da home
                    Text("Produtos em destaque")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    
                    // Lista de produtos
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    } else if let errorMessage = viewModel.errorMessage {
                        ErrorView(message: errorMessage) {
                            Task { await viewModel.loadProducts() }
                        }
                        .padding()
                    } else {
                        VStack(spacing: 16) {
                            ForEach(viewModel.products, id: \.id) { product in
                                ProductCardH(product: product)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Home")
            .background(.backgroundsPrimary)
            .refreshable {
                await viewModel.loadProducts()
            }
        }
        .task {
            // Atualiza o modelContext da ViewModel quando o contexto real estiver disponível
            viewModel.modelContext = modelContext
            await viewModel.loadProducts()
        }
    }
}
