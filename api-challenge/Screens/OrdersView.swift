//
//  OrdersView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//


import SwiftUI

struct OrdersView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Orders")
                    .font(.largeTitle)
                    .bold()
            }
            .navigationTitle("Orders")
        }
    }
}

#Preview {
    OrdersView()
}
