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
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.fillsTertiary)))
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
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(2) // no máximo 2 linhas
                    .multilineTextAlignment(.leading)
                    .frame(height: 36, alignment: .topLeading) // reserva espaço fixo p/ 2 linhas
                    .accessibilityLabel("Name of the product:" + product.title)
                
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .accessibilityLabel("Price: \(product.price)")
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

// MARK: - Preview

#if DEBUG
struct ProductCardV_Previews: PreviewProvider {
    static var previews: some View {
        let sampleProduct = ProductDTO(
            id: 1,
            title: "Example Product With a Really Long Name",
            description: "saas",
            category: "This is a sample description for preview purposes.",
            price: 190.00, thumbnail: "https://via.placeholder.com/150"
        )
        
        Group {
            ProductCardV(
                product: sampleProduct,
                isFavorited: false,
                onToggleFavorite: { print("Favorited toggled!") },
                onTapProduct: { print("Card tapped!") }
            )
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Default State")
            
            ProductCardV(
                product: sampleProduct,
                isFavorited: true,
                onToggleFavorite: { print("Favorited toggled!") },
                onTapProduct: { print("Card tapped!") }
            )
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Favorited State")
        }
    }
}
#endif
