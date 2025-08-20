//
//  HomeView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//
import SwiftUI
import SwiftData

struct CategoriesView: View {
    @Environment(\.diContainer) private var container
    @State private var searchText = ""
    @StateObject private var vm: CategoriesVM
    @State private var selectedCategory: String? = nil  // para navegação

    init(vm: CategoriesVM){
        _vm = StateObject(wrappedValue: vm)
    }

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
                    
                    if vm.isLoading {
                        ProgressView()
                    } else if let errorMessage = vm.errorMessage {
                        ErrorView(message: errorMessage) {
                            Task { await vm.loadCategories() }
                        }
                    } else {
                        CategoryListView(
                            apiCategories: vm.apiCategories,
                            onTapCategory: { category in
                                selectedCategory = category
                            }
                        )
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Categorias")
            .searchable(text: $searchText, prompt: "Buscar...")
            .background(.backgroundsPrimary)
            .refreshable {
                await vm.loadCategories()
            }
            .navigationDestination(
                isPresented: Binding(
                    get: { selectedCategory != nil },
                    set: { if !$0 { selectedCategory = nil } }
                )
            ) {
                if let category = selectedCategory {
                    CategoryProductsView(
                        vm: CategoryProductsVM(categoryName: category, apiService: container.apiService, productsService: container.userProductsService)
                    )
                }
            }
        }
        .task {
            await vm.loadCategories()
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
