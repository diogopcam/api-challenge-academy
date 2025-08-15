//
//  TabBar.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

import SwiftUI

struct TabBar: View {
   
    // Instâncias das ViewModels
    private let categoriesVM = CategoriesVM()
    private let homeVM = HomeVM()
    // Adicione aqui as outras ViewModels conforme necessário
    // private let cartVM = CartViewModel()
    // private let favoritesVM = FavoritesViewModel()
    // private let ordersVM = OrdersViewModel()
    
    var body: some View {
        TabView {
            // Home Tab
            NavigationStack {
                HomeView(viewModel: homeVM)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            // Categories Tab
            NavigationStack {
                CategoriesView(viewModel: categoriesVM)
            }
            .tabItem {
                Label("Categories", systemImage: "square.grid.2x2.fill")
            }
            
            // Cart Tab
            NavigationStack {
                CartView()
            }
            .tabItem {
                Label("Cart", systemImage: "cart.fill")
            }
            
            // Favorites Tab
            NavigationStack {
                FavoritesView()
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
            
            // Orders Tab
            NavigationStack {
                OrdersView()
            }
            .tabItem {
                Label("Orders", systemImage: "bag.fill")
            }
        }
        .tint(.colorsBlue)
    }
}

#Preview {
    TabBar()
        .modelContainer(for: Product.self, inMemory: true) // Preview com banco temporário
}
