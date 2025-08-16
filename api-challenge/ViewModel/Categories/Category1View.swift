//
//  Category1View.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 15/08/25.
//

import SwiftUI
import SwiftData

struct Category1View: View {
    let categoryName: String
    @State private var searchText = ""
    @State private var selectedProduct: ProductDTO? = nil
    @State private var viewModel = CategoryProductsVM()
    
    @Environment(\.modelContext) private var modelContext
    @State private var cartViewModel: CartViewModel? = nil


    var body: some View {
        List {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            } else {
                Section {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 8),
                        GridItem(.flexible(), spacing: 8)
                    ], spacing: 8) {
                        ForEach(viewModel.products) { product in
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
                    if let cartVM = cartViewModel {
                        ProductDetailsSheet(cartVM: Binding(get: { cartVM }, set: { cartViewModel = $0 }), product: product)
                    }
                }
        .task {
            await viewModel.loadProducts(for: categoryName)
        }
        .onAppear {
                    if cartViewModel == nil {
                        cartViewModel = CartViewModel(context: modelContext)
                    }
                }
    }
}


//#Preview {
//    Category1View()
//}
