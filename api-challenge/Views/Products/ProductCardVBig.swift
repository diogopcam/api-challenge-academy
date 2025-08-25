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
                .frame(width: 329, height: 329)
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
                .padding(12)
            }

            Text(product.title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .lineLimit(2)
                .accessibilityLabel("Name of the product:" + product.title)

            Text("R$ \(product.price, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(.secondary)
                .accessibilityLabel("Price: \(product.price)")
        }
        .padding(.horizontal, 16)
        .frame(width: 361, height: 459)
        .accessibilityElement(children: .combine)
    }
}
