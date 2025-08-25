//
//  EmptyStateOrders.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 14/08/25.
//

import SwiftUI

struct EmptyStateOrders: View {
    var body: some View {
        
        VStack(spacing: 32) {
            VStack(spacing: 8) {
                Image(.emptyStateOrders)
                    .resizable()
                    .frame(width: 65, height: 69)
                    .accessibilityHidden(true)
                VStack(spacing: 16) {
                    Text("No Orders yet!")
                        .font(.system(.body, weight: .semibold))
                        .foregroundStyle(.labelsPrimary)
                    
                    Text("Buy an item and it will show up here.")
                        .foregroundStyle(.labelsSecondary)
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text("empty_orders_state"))
        .accessibilityHint(Text("empty_orders_hint"))
    }
}

#Preview {
    EmptyStateOrders()
}
