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
    
    var filteredCategories: [String] {
        if searchText.isEmpty {
            return vm.apiCategories
        } else {
            return vm.apiCategories.filter { category in
                let formatter = CategoryFormatter(apiValue: category)
                return formatter.formattedName.localizedCaseInsensitiveContains(searchText) ||
                       category.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    HStack(spacing: 8) {
                        CategoryCard(apiCategoryName: "smartphones", onTap: {
                            selectedCategory = "smartphones"
                        })
                        CategoryCard(apiCategoryName: "laptops", onTap: {
                            selectedCategory = "laptops"
                        })
                        CategoryCard(apiCategoryName: "womens-dresses", onTap: {
                            selectedCategory = "womens-dresses"
                        })
                        CategoryCard(apiCategoryName: "fragrances", onTap: {
                            selectedCategory = "fragrances"
                        })
                    }
                    .padding(.horizontal)
                    
                    if vm.isLoading {
                        ProgressView()
                    } else if let errorMessage = vm.errorMessage {
                        ErrorView(message: errorMessage) {
                            Task { await vm.loadCategories() }
                        }
                    } else if !filteredCategories.isEmpty { // ← Use filteredCategories aqui
                        CategoryListView(
                            apiCategories: filteredCategories, // ← Filtradas
                            onTapCategory: { category in
                                selectedCategory = category
                            }
                        )
                    } else {
                        // Estado vazio quando não há resultados
                        VStack {
                            Text(searchText.isEmpty ? "No categories found" : "No results for \"\(searchText)\"")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, minHeight: 200)
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
