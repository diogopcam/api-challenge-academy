//
//  ProductCardV.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 14/08/25.
//

import SwiftUI

struct ProductCardV: View {
    let product: ProductDTO
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 161, height: 160)
                        .cornerRadius(8)
                } placeholder: {
                    Color.gray
                        .frame(width: 160, height: 160)
                        .cornerRadius(8)
                }

                Button {
                    print("Coração clicado!")
                } label: {
                    Image(systemName: "heart")
                        .foregroundColor(.labelsPrimary)
                        .frame(width: 18, height: 18)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.fillsTertiary)
                        )
                }
            }
            .frame(width: 160, height: 160)
            .padding(.horizontal, 8)
            .padding(.top, 8)

            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .frame(height: 40, alignment: .topLeading)
                    .lineLimit(2)
                    .font(.system(size: 15, weight: .regular))
                Text("US$ \(product.price)")
                    .font(.system(size: 17, weight: .semibold))
            }
            .frame(width: 160, alignment: .leading) // garante alinhamento
            .padding(.bottom, 8)
            .padding(.horizontal, 8)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundsSecondary)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16)) // garante que nada vaze
    }
}

//#Preview {
//    ImageCardWithHeart(imageURL: "https://picsum.photos/200")
//}
