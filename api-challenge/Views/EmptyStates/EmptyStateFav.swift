//
//  EmptyStateFav.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 14/08/25.
//

import SwiftUI

struct EmptyStateFav: View {
    var body: some View {
        
        VStack(spacing: 32){
            VStack(spacing: 8) {
                Image(.emptyStateFav)
                    .resizable()
                    .frame(width: 65, height: 69)
                VStack(spacing: 16) {
                    Text("No favorites yet!")
                        .font(.system(.body, weight: .semibold))
                        .foregroundStyle(.labelsPrimary)
                        .accessibilityLabel("No products in favorites")
                    
                    Text("Favorite an item and it show up here.")
                        .foregroundStyle(.labelsSecondary)
                        .accessibilityLabel("Add a product to favorites and it show up here.")
                }
            }
        }
    }
}

#Preview {
    EmptyStateFav()
}
