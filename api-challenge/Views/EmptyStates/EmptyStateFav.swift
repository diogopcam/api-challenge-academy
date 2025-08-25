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
                    .accessibilityHidden(true)
                VStack(spacing: 16) {
                    Text("No favorites yet!")
                        .font(.system(.body, weight: .semibold))
                        .foregroundStyle(.labelsPrimary)
                    
                    Text("Favorite an item and it show up here.")
                        .foregroundStyle(.labelsSecondary)
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text("empty_favorites_state"))
        .accessibilityHint(Text("empty_favorites_hint"))
    }
}

#Preview {
    EmptyStateFav()
}
