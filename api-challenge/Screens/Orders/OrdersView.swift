//
//  OrdersView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftUI
import SwiftData

struct OrdersView: View {
    @StateObject private var vm: OrdersVM
    @State private var searchText = ""

    init(vm: OrdersVM) {
        _vm = StateObject(wrappedValue: vm)
    }

    var filteredProducts: [OrderProductDisplay] {
        let products = searchText.isEmpty
            ? vm.orderedProducts
            : vm.orderedProducts.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        
        return products.sorted { ($0.dateOrdered) > ($1.dateOrdered) }
    }
    
    var productsListView: some View {
        VStack(spacing: 12) {
            ForEach(filteredProducts) { product in
                ProductCell(image: product.thumbnail, productName: product.title, price: product.price, variant: ProductListStyle.delivery, dateOrdered: product.dateOrdered)
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
                            Task {
                                await vm.fetchOrderedProducts()
                            }
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
                await vm.fetchOrderedProducts()
            }
        }
        .task {
            await vm.fetchOrderedProducts()
        }
    }
}
