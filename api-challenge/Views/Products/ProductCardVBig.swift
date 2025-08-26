//
//  ProductCardVBig.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 15/08/25.
//

import SwiftUI
import SwiftData

struct ProductCardVBig: View {
    let product: ProductDTO
    let isFavorited: Bool
    let onToggleFavorite: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    Image(.placeholder).resizable().scaledToFit()
                }
                .frame(height: 329)
                .frame(maxWidth: .infinity)
                .cornerRadius(16)

                Button {
                    onToggleFavorite()
                } label: {
                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 35, height: 34)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.systemGray5)))
                        .foregroundStyle(.labelsPrimary)
                        .accessibilityLabel(isFavorited ? "Item not favorited" : "Item favorited")
                        .accessibilityHint("Tap to toggle favorite")
                }
                .accessibilityElement(children: .combine)
                .padding(8)
            }

            VStack(alignment: .leading, spacing: 4){
                Text(product.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .accessibilityLabel("Name of the product:" + product.title)

                Text("US$ \(product.price, specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .accessibilityLabel("Price: \(String(format: "%.2f", product.price))")
            }
           
            
        }
        .frame(height: 459)
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
    }
}





