//
//  CategoryIcon.swift
//  api-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//

import SwiftUI

struct CategoryCard: View {
    let apiCategoryName: String
    var onTap: (() -> Void)? = nil
    
    public var category: CategoryFormatter {
        CategoryFormatter(apiValue: apiCategoryName)
    }
    
    private let cardSize: CGFloat = 84
    private let cornerRadius: CGFloat = 16
    private let iconSize: CGFloat = 38.88
    private let labelFont: Font = .system(size: 15, weight: .regular)
    private let paddingTop: CGFloat = 8
    
    var body: some View {
        Button(action: {
            onTap?()
        }) {
            VStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.fillsQuaternary)
                        .frame(width: cardSize, height: cardSize)
                        .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(.fillsQuaternary)
                        )
                    
                    Image(systemName: category.iconName)
                        .font(.system(size: iconSize, weight: .regular))
                        .foregroundColor(.fillsSecondary)
                }
                
                Text(category.formattedName)
                    .font(labelFont)
                    .padding(.top, paddingTop)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
        .frame(width: cardSize)
        .buttonStyle(PlainButtonStyle())
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text("category_card_label \(category.formattedName)"))
        .accessibilityHint(Text("category_card_hint"))
        .accessibilityAddTraits(.isButton)
    }
}
