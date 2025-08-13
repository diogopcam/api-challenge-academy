//
//  FavoritesView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//


import SwiftUI

struct FavoritesView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Favorites")
                    .font(.largeTitle)
                    .bold()
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView()
}
