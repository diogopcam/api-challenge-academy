//
//  CartView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//


import SwiftUI

struct CartView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Cart")
                    .font(.largeTitle)
                    .bold()
            }
            .navigationTitle("Cart")
        }
    }
}

#Preview {
    CartView()
}
