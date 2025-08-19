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
                HomeView(vm: HomeVM(apiService: container.productsServiceApi))
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
                CategoriesView()
            }
            .tabItem {
                Label("Categories", systemImage: "square.grid.2x2.fill")
            }
            
            // Cart Tab
            CartView(
                vm: CartVM(
                    productsService: container.userProductsService,
                    apiService: container.productsServiceApi
                )
            )
            .tabItem {
                Label("Cart", systemImage: "cart.fill")
            }
            
            // Favorites Tab
            NavigationStack {
                FavoritesView(
                    vm: FavoritesVM(
                            apiService: container.productsServiceApi,
                            userProductsService: container.userProductsService
                    )
                )
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
            
            // Orders Tab
            NavigationStack {
                OrdersView(
                    vm: OrdersVM(
                        apiService: container.productsServiceApi,
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

//#Preview {
//    TabBar()
//        .environment(\.diContainer, DIContainer.createForTesting())
//        .modelContainer(for: Product.self, inMemory: true)
//}
