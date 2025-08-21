//
//  OrdersView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 21/08/25.
//


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

    init(vm: OrdersVM) {
        _vm = StateObject(wrappedValue: vm)
    }

    var filteredProducts: [ProductDTO] {
        if searchText.isEmpty {
            return vm.orderedProducts
        } else {
            return vm.orderedProducts.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var productsListView: some View {
        VStack(spacing: 12) {
            ForEach(filteredProducts) { product in
                ProductCell(image: product.thumbnail, productName: product.title, price: product.price, variant: .delivery(month: "DECEMBER", day: "15"))
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
            .navigationTitle("OrdersView")
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
