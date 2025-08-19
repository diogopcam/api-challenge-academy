//
//  HomeView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//
import SwiftUI
import SwiftData

struct CategoriesView: View {
    @State private var searchText = ""
    @State private var VM: CategoriesVM
    @Environment(\.modelContext) private var modelContext
    
    init() {
        // Contexto temporário para inicialização (será substituído)
//        _ = try! ModelContext(ModelContainer(for: Product.self))
        VM = CategoriesVM()
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
                    
                    // Lista completa de categorias
                    if VM.isLoading {
                        ProgressView()
                    } else if let errorMessage = VM.errorMessage {
                        ErrorView(message: errorMessage) {
                            Task { await VM.loadCategories() }
                        }
                    } else {
                        CategoryListView(apiCategories: VM.apiCategories)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Categorias")
            .searchable(text: $searchText, prompt: "Buscar...")
            .background(.backgroundsPrimary)
            .refreshable {
                await VM.loadCategories()
            }
        }
        .task {
            await VM.loadCategories()
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
