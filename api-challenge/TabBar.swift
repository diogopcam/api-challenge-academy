//
//  TabBar.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

import SwiftUI

import SwiftUI

struct TabBar: View {
    @Environment(\.diContainer) private var container
    
    var body: some View {
        TabView {
            // Home Tab
            NavigationStack {
                HomeView(
                    vm: HomeVM(
                        apiService: container.apiService,
                        productsService: container.userProductsService
                ))
            }
//            NavigationStack {
//                OrdersView(
//                    vm: OrdersVM(service: container.userProductsService)
//                )
//            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            // Categories Tab
            NavigationStack {
                CategoriesView(
                    vm: CategoriesVM(
                        apiService: container.apiService
//                        productsService: container.userProductsService
                    )
                )
            }
            .tabItem {
                Label("Categories", systemImage: "square.grid.2x2.fill")
            }
            
            CartView(
                vm: CartVM(
                    apiService: container.apiService,
                    productsService: container.userProductsService
                )
            )
            .tabItem {
                Label("Cart", systemImage: "cart.fill")
            }
            
            NavigationStack {
                FavoritesView(
                    vm: FavoritesVM(
                            apiService: container.apiService,
                            productsService: container.userProductsService
                    )
                )
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
            
            NavigationStack {
                OrdersView(
                    vm: OrdersVM(
                        apiService: container.apiService,
                        service: container.userProductsService
                    )
                )
            }
            .tabItem {
                Label("Orders", systemImage: "bag.fill")
            }
        }
        .tint(.colorsBlue)
    }
}
