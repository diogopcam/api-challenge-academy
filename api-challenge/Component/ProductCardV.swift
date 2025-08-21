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
        VStack(spacing: 8) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 177, height: 160)
                        .clipped()
                } placeholder: {
                    Image(.placeholder)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 177, height: 160)
                        .clipped()
                }
                .cornerRadius(16)
                
                Button {
                    onToggleFavorite()
                } label: {
                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.fillsTertiary)))
                        .foregroundStyle(isFavorited ? .labelsPrimary : .labelsPrimary)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .frame(height: 36, alignment: .top) // força altura para 2 linhas
                
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            
//            Spacer() // garante que o card tenha altura consistente
        }
        .frame(width: 177, height: 250) // força dimensões do card
        .background(.backgroundsSecondary)
        .cornerRadius(16)
        .padding(8)
        .onTapGesture {
            onTapProduct()
        }
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
