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
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Product> { $0.isFavorite == true })
    private var favorites: [Product]

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
                    toggleFavorite()
                } label: {
                    Image(systemName: isFavorited() ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 35, height: 34)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.systemGray5)))
                        .foregroundStyle(.labelsPrimary)
                }
                .padding(12)
            }

            Text(product.title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .lineLimit(2)

            Text("R$ \(product.price, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 16)
        .frame(width: 361, height: 459)
    }

    private func isFavorited() -> Bool {
            favorites.contains { $0.id == product.id }
        }

    private func toggleFavorite() {
            if let existing = favorites.first(where: { $0.id == product.id }) {
                existing.isFavorite = false
            } else {
                let newProduct = Product(from: product, type: .favorites)
                newProduct.isFavorite = true
                modelContext.insert(newProduct)
            }
            try? modelContext.save()
    }
}
