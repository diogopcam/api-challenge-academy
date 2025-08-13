//
//  HomeView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//
import SwiftUI

struct CategoriesView: View {
    let viewModel: CategoriesVM
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            } else {
                List(viewModel.categories, id: \.self) { category in
                    Text(category)
                }
                .navigationTitle("Categories")
                .refreshable {
                    await viewModel.loadCategories()
                }
            }
        }
        .task {
            await viewModel.loadCategories()
        }
    }
}

#Preview {
    CategoriesView(viewModel: CategoriesVM())
}
