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
                VStack(spacing: 16) {
                    Text("No orders yet!")
                        .font(.system(.body, weight: .semibold))
                        .foregroundStyle(.labelsPrimary)
                    
                    Text("Buy an item and it will show up here.")
                        .foregroundStyle(.labelsSecondary)
                }
            }
        }
        
        
        
    }
}

#Preview {
    EmptyStateOrders()
}
