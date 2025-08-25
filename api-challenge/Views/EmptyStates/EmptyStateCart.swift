//
//  EmptyStateCart.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 14/08/25.
//

import SwiftUI

struct EmptyStateCart: View {
    var body: some View {
        
        VStack(spacing: 32) {
            VStack(spacing: 8) {
                Image(.emptyStateCart)
                    .resizable()
                    .frame(width: 75, height: 69)
                VStack(spacing: 16) {
                    Text("Your cart is empty!")
                        .font(.system(.body, weight: .semibold))
                        .foregroundStyle(.labelsPrimary)
                        .accessibilityLabel(Text("Your cart is empty!"))
                    
                    Text("Add an item to your cart.")
                        .foregroundStyle(.labelsSecondary)
                        .accessibilityLabel(Text("Add an item to your cart."))
                }
            }
        }
    }
}

#Preview {
    EmptyStateCart()
}
