//
//  ProductCardH.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 14/08/25.
//

import SwiftUI

struct ProductCardH: View {
    let product: ProductDTO
    
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
                    
                    Text(String(format: "US$ %.2f", product.price))
                        .font(.system(.body, weight: .semibold))
                        .foregroundStyle(.labelsPrimary)
                }
                .padding(.top, 8)
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
            
            Button {
                print("Coração clicado")
            } label: {
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.fillsTertiary)
                    )
                    .foregroundColor(.labelsPrimary)
            }
            .frame(width: 38, height: 38)
            .padding(8)
        }
        .frame(width: 368, height: 176)
    }
}

    

#Preview {
    TabBar()
}
