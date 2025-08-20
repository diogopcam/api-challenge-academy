//
//  CategoryList.swift
//  api-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//

import SwiftUI

struct CategoryList: View {
    let apiCategoryName: String
    var onTap: (() -> Void)? = nil  // closure opcional

    var formattedName: String {
        CategoryFormatter(apiValue: apiCategoryName).formattedName
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(formattedName)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.labelsPrimary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.labelsTertiary)
            }
            .padding(.vertical, 19)
            .contentShape(Rectangle())   // garante que o HStack inteiro seja clicável
            .onTapGesture {
                onTap?()  // chamada segura da closure
            }

            Divider()
                .frame(height: 0.33)
                .overlay(.separatorsNonopaque)
        }
        .padding(.horizontal)
    }
}
