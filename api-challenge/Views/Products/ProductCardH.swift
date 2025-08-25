//
//  ProductCardH.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 14/08/25.
//

import SwiftUI

struct ProductCardH: View {
    let product: ProductDTO
    let isFavorited: Bool
    let onToggleFavorite: () -> Void
    let onTapProduct: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(spacing: 12) {
                // Imagem
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 160)
                        .cornerRadius(16)
                } placeholder: {
                    Image(.placeholder)
                        .resizable()
                        .frame(width: 160, height: 160)
                        .cornerRadius(16)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(product.title)
                        .foregroundStyle(.labelsPrimary)
                        .font(.system(size: 15, weight: .regular))
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .frame(width: 169, alignment: .topLeading)
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibilityLabel("Name of the product:" + product.title)
                    
                    Text(String(format: "US$ %.2f", product.price))
                        .font(.system(.body, weight: .semibold))
                        .foregroundStyle(.labelsPrimary)
                        .accessibilityLabel("Price: \(String(format: "%.2f", product.price))")
                }
                .padding(.top, 8)
                .accessibilityElement(children: .combine)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.backgroundsSecondary)
            )

            Text(CategoryFormatter(apiValue: product.category).formattedName.uppercased())
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.labelsSecondary)
                .padding(.trailing, 130)
                .padding(.top, 22)
                .accessibilityLabel("Category: \(CategoryFormatter(apiValue: product.category).formattedName)")
            
            Button {
                onToggleFavorite()
            } label: {
                Image(systemName: isFavorited ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.fillsTertiary)
                    )
                    .foregroundStyle(isFavorited ? .labelsPrimary : .labelsPrimary)
                    .accessibilityLabel(isFavorited ? "Item not favorited" : "Item favorited")
                    .accessibilityHint("Tap to toggle favorite")
            }
            .accessibilityElement(children: .combine)
            .frame(width: 38, height: 38)
            .padding(8)
        }
        .onTapGesture {
            onTapProduct()
        }
        .frame(width: 368, height: 176)
        .accessibilityElement(children: .combine)
    }
}

    

#Preview {
    TabBar()
}
