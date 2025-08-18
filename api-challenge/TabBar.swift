//
//  TabBar.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

import SwiftUI

struct TabBar: View {
    // Removemos as instâncias diretas das ViewModels
    // Elas serão criadas dentro de cada View com o contexto apropriado
    @EnvironmentObject var userProductsService: UserProductsService
    
    var body: some View {
        TabView {
            // Home Tab
            NavigationStack {
                HomeView() // Agora inicializa seu próprio ViewModel com o contexto
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            // Categories Tab
            NavigationStack {
                CategoriesView() // Mesmo padrão para Categories
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
                OrdersView(service: userProductsService)            }
            .tabItem {
                Label("Orders", systemImage: "bag.fill")
            }
        }
        .tint(.colorsBlue)
    }
}

#Preview {
    TabBar()
        .modelContainer(for: Product.self, inMemory: true)
}
