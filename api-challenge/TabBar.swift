//
//  TabBar.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//


import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {

            }

            Tab("Categories", systemImage: "square.grid.2x2.fill") {
                
            }

            Tab("Cart", systemImage: "cart.fill") {
                
            }
            Tab("Favorites", systemImage: "heart.fill") {
                
            }
            Tab("Orders", systemImage: "bag.fill") {
                
            }
            
        }
        .tint(.colorsBlue)
    }
}

#Preview {
    TabBar()
}

