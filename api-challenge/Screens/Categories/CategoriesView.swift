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
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    // 🔹 Categorias principais
    private let mainCategories = [
        "smartphones",
        "laptops",
        "womens-dresses",
        "fragrances",
        "skincare",
        "groceries",
        "home-decoration",
        "mens-shoes"
    ]

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
                    
                    // 🔹 Grade de categorias principais
                    let columnCount = (horizontalSizeClass == .regular) ? 8 : 4
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: columnCount)
                    
                    let displayedCategories = (horizontalSizeClass == .regular)
                        ? Array(mainCategories.prefix(8)) // iPad → 8 categorias
                        : Array(mainCategories.prefix(4)) // iPhone → 4 categorias
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(displayedCategories, id: \.self) { category in
                            CategoryCard(apiCategoryName: category) {
                                selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // 🔹 Estados de carregamento/erro/lista
                    if vm.isLoading {
                        ProgressView()
                    } else if let errorMessage = vm.errorMessage {
                        ErrorView(message: errorMessage) {
                            Task { await vm.loadCategories() }
                        }
                    } else if !filteredCategories.isEmpty {
                        CategoryListView(
                            apiCategories: filteredCategories,
                            onTapCategory: { category in
                                selectedCategory = category
                            }
                        )
                    } else {
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
                        vm: CategoryProductsVM(
                            categoryName: category,
                            apiService: container.apiService,
                            productsService: container.userProductsService
                        )
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
