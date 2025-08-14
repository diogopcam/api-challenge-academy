//
//  HomeView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//
import SwiftUI

struct CategoriesView: View {
    @Bindable var viewModel: CategoriesVM
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                        

                    HStack(spacing: 8) {
                            CategoryCard(apiCategoryName: "smartphones")
                            CategoryCard(apiCategoryName: "laptops")
                            CategoryCard(apiCategoryName: "womens-dresses")
                            CategoryCard(apiCategoryName: "fragrances")
                        }
                        .padding(.horizontal)
                    
                    // Lista completa de categorias
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let errorMessage = viewModel.errorMessage {
                        ErrorView(message: errorMessage) {
                            Task { await viewModel.loadCategories() }
                        }
                    } else {
                        CategoryListView(apiCategories: viewModel.apiCategories)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Categorias")
            .searchable(text: $searchText, prompt: "Buscar...")
            .background(.backgroundsPrimary)
            .refreshable {
                await viewModel.loadCategories()
            }
        }
        .task {
            await viewModel.loadCategories()
        }
    }
}


// View de erro reutilizável
struct ErrorView: View {
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Text(message)
                .foregroundColor(.red)
            
            Button("Try Again") {
                retryAction()
            }
        }
    }
}
