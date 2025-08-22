//
//  TabBar.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

import SwiftUI

struct TabBar: View {
    @Environment(\.diContainer) private var container
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView(
                    vm: HomeVM(
                        apiService: container.apiService,
                        productsService: container.userProductsService
                    )
                )
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            // Categories Tab
            NavigationStack {
                CategoriesView(
                    vm: CategoriesVM(
                        apiService: container.apiService
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
                Label("OrdersView", systemImage: "bag.fill")
            }
        }
        .tint(.colorsBlue)
    }
}
