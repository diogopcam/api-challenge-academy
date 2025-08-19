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
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Product> { $0.isFavorite == true })
    private var favorites: [Product]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Image(.placeholder).resizable().scaledToFill()
                }
                .frame(width: 161, height: 160)
                .clipped()
                .cornerRadius(16)

                Button {
//                    toggleFavorite()
                } label: {
                    Image(systemName: isFavorited() ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.systemGray5)))
                        .foregroundStyle(.labelsPrimary)
                }
                .padding(8)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(2)

                Text("R$ \(product.price, specifier: "%.2f")")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .frame(width: 161)
        .background(.backgroundsPrimary)
        .cornerRadius(16)
    }

    private func isFavorited() -> Bool {
            favorites.contains { $0.id == product.id }
        }

//    private func toggleFavorite() {
//            if let existing = favorites.first(where: { $0.id == product.id }) {
//                existing.isFavorite = false
//            } else {
//                let newProduct = Product(from: product, type: .favorites)
//                newProduct.isFavorite = true
//                modelContext.insert(newProduct)
//            }
//            try? modelContext.save()
//    }
}
