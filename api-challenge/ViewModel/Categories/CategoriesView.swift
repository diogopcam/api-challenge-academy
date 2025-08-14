//
//  HomeView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//
import SwiftUI

struct CategoriesView: View {
    @Bindable var viewModel: CategoriesVM
    
    var body: some View {
        NavigationStack {
            Group {
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
            .navigationTitle("Categories")
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
