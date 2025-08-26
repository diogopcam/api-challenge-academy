//
//  ProductCardV.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 14/08/25.
//

import SwiftUI
import SwiftData

struct ProductCardV: View {
    let product: ProductDTO
    let isFavorited: Bool
    let onToggleFavorite: () -> Void
    let onTapProduct: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 8)
                        .padding(.top, 8)
                } placeholder: {
                    Image(.placeholder)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 8)
                        .padding(.top, 8)
                }
                .cornerRadius(16)
                Button {
                    onToggleFavorite()
                } label: {
                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(isFavorited ? .labelsPrimary : .labelsPrimary)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color(.fillsTertiary))
                        )
                        .accessibilityLabel(isFavorited ? "Item not favorited" : "Item favorited")
                        .accessibilityHint("Tap to toggle favorite")
                }
                .accessibilityElement(children: .combine)
                .padding(8)
            }
            
            // Texto
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.labelsPrimary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(height: 36, alignment: .topLeading)
                    .accessibilityLabel("Name of the product:" + product.title)
                
                Text("US$ \(product.price, specifier: "%.2f")")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.labelsPrimary)
                    .multilineTextAlignment(.leading)
                    .accessibilityLabel("Price: \(String(format: "%.2f", product.price))")
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 8)
            .accessibilityElement(children: .combine)
        }
        .frame(width: 177, height: 250) // tamanho do card
        .background(.backgroundsSecondary)
        .cornerRadius(16)
        .onTapGesture {
            onTapProduct()
        }
        .padding(.horizontal, 8)
        .accessibilityElement(children: .combine)
    }
}
