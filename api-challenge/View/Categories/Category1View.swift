//
//  Category1View.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 15/08/25.
//

import SwiftUI
import SwiftData

//struct Category1View: View {
//    let categoryName: String
//    @State private var searchText = ""
//    @State private var selectedProduct: ProductDTO? = nil
//    @State private var VM = CategoryProductsVM()
//    
//    @Environment(\.modelContext) private var modelContext
//    @State private var cartVM: CartVM? = nil
//
//
//    var body: some View {
//        List {
//            if VM.isLoading {
//                ProgressView()
//            } else if let error = VM.errorMessage {
//                Text(error).foregroundColor(.red)
//            } else {
//                Section {
//                    LazyVGrid(columns: [
//                        GridItem(.flexible(), spacing: 8),
//                        GridItem(.flexible(), spacing: 8)
//                    ], spacing: 8) {
//                        ForEach(VM.products) { product in
//                            ProductCardV(product: product)
//                                .onTapGesture {
//                                    selectedProduct = product
//                                }
//                                .listRowInsets(EdgeInsets())
//                        }
//                    }
//                    .padding(.vertical, 8)
//                }
//            }
//        }
//        .listStyle(.plain)
//        .navigationTitle(categoryName)
//        .navigationBarTitleDisplayMode(.inline)
//        .searchable(text: $searchText, prompt: "Search...")
//        .sheet(item: $selectedProduct) { product in
//                    if let cartVM = cartVM {
//                        ProductDetailsSheet(cartVM: Binding(get: { cartVM }, set: { cartVM = $0 }), product: product)
//                    }
//                }
//        .task {
//            await VM.loadProducts(for: categoryName)
//        }
//        .onAppear {
//                    if cartVM == nil {
//                        cartVM = CartVM(context: modelContext)
//                    }
//                }
//    }
//}

//struct Category1View: View {
//    let categoryName: String
//    @State private var searchText = ""
//    @State private var selectedProduct: ProductDTO? = nil
//    @State private var VM = CategoryProductsVM()
//    
//    @Environment(\.modelContext) private var modelContext
//    @State private var cartVM: CartVM? = nil
//    @State private var favoritesVM: FavoritesVM = .init(context: .init())
//
//    var body: some View {
//        List {
//            if VM.isLoading {
//                ProgressView()
//            } else if let error = VM.errorMessage {
//                Text(error).foregroundColor(.red)
//            } else {
//                Section {
//                    LazyVGrid(columns: [
//                        GridItem(.flexible(), spacing: 8),
//                        GridItem(.flexible(), spacing: 8)
//                    ], spacing: 8) {
//                        ForEach(VM.products) { product in
//                            ProductCardV(product: product, favoritesVM: favoritesVM)
//                                .onTapGesture {
//                                    selectedProduct = product
//                                }
//                                .listRowInsets(EdgeInsets())
//                        }
//                    }
//                    .padding(.vertical, 8)
//                }
//            }
//        }
//        .listStyle(.plain)
//        .navigationTitle(categoryName)
//        .navigationBarTitleDisplayMode(.inline)
//        .searchable(text: $searchText, prompt: "Search...")
//        .sheet(item: $selectedProduct) { product in
//            if let cartVM = cartVM {
//                ProductDetailsSheet(cartVM: Binding(get: { cartVM }, set: { cartVM = $0 }),
//                                    favoritesVM: favoritesVM,
//                                    product: product)
//            }
//        }
//        .task {
//            await VM.loadProducts(for: categoryName)
//        }
//        .onAppear {
//            if cartVM == nil {
//                cartVM = CartVM(context: modelContext)
//            }
//        }
//    }
//}


struct Category1View: View {
    let categoryName: String
    @State private var searchText = ""
    @State private var selectedProduct: ProductDTO? = nil
    @State private var VM = CategoryProductsVM()
    
    @Environment(\.modelContext) private var modelContext
    @State private var cartVM: CartVM? = nil

    var body: some View {
        List {
            if VM.isLoading {
                ProgressView()
            } else if let error = VM.errorMessage {
                Text(error).foregroundColor(.red)
            } else {
                Section {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 8),
                        GridItem(.flexible(), spacing: 8)
                    ], spacing: 8) {
                        ForEach(VM.products) { product in
                            ProductCardV(product: product)
                                .onTapGesture {
                                    selectedProduct = product
                                }
                                .listRowInsets(EdgeInsets())
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle(categoryName)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Search...")
        .sheet(item: $selectedProduct) { product in
            if let cartVM = cartVM {
                ProductDetailsSheet(product: product)
            }
        }
        .task {
            await VM.loadProducts(for: categoryName)
        }
        .onAppear {
            if cartVM == nil {
                cartVM = CartVM(context: modelContext)
            }
        }
    }
}


//#Preview {
//    Category1View()
//}
