//
//  CategoryIcon.swift
//  api-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//

import SwiftUI

struct CategoryCard: View {
    let apiCategoryName: String
    
    public var category: CategoryFormatter {
        CategoryFormatter(apiValue: apiCategoryName)
    }
    
    private let cardSize: CGFloat = 84
    private let cornerRadius: CGFloat = 16
    private let iconSize: CGFloat = 38.88
    private let labelFont: Font = .system(size: 15, weight: .regular)
    private let paddingTop: CGFloat = 8
    
    var body: some View {
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
            
            // Label da categoria
            Text(category.formattedName)
                .font(labelFont)              // mantém sempre a mesma fonte
                .padding(.top, paddingTop)
                .lineLimit(1)                  // no máximo 1 linha
                .truncationMode(.tail)
        }
        .frame(width: cardSize)
    }
}
