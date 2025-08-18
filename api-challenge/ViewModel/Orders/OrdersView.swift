//
//  OrdersView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

import SwiftUI
import SwiftData

struct OrdersView: View {
    @StateObject private var vm: OrdersVM
    @State private var searchText = ""

    init(service: any UserProductsServiceProtocol) {
        _vm = StateObject(wrappedValue: OrdersVM(service: service))
    }

    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return vm.orderedProducts
        } else {
            return vm.orderedProducts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var productsListView: some View {
        VStack(spacing: 12) {
            ForEach(filteredProducts) { product in
                ProductListAsyncImage(image: product.thumbnail, productName: product.name, price: product.price, variant: .delivery(month: "DECEMBER", day: "15"))
            }
        }
        .padding(.horizontal)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    if vm.isLoading {
                        ProgressView()
                    } else if let errorMessage = vm.errorMessage {
                        ErrorView(message: errorMessage) {
                            vm.fetchOrderedProducts()
                        }
                    } else {
                        productsListView
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Orders")
            .searchable(text: $searchText, prompt: "Search")
            .refreshable {
                vm.fetchOrderedProducts()
            }
        }
        .task {
            vm.fetchOrderedProducts()
        }
    }
}

