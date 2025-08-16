//
//  ProductCardVBig.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 15/08/25.
//

import SwiftUI

struct ProductCardVBig: View {
    let product: ProductDTO

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack(alignment: .topTrailing) {
//                Image(.placeholder)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 329, height: 329)
//                    .clipped()
//                    .cornerRadius(16)
                AsyncImage(url: URL(string: product.thumbnail)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 329, height: 329)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 329, height: 329)
                            .clipped()
                            .cornerRadius(16)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 329, height: 329)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }


                Button(action: {}) {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 35, height: 34)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color(.systemGray5))
                        )
                        .foregroundStyle(.labelsPrimary)
                }
                .frame(width: 51, height: 51)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .frame(height: 50)
                    .padding(.horizontal, 4)

                Text("US$ \(String(format: "%.2f", product.price))")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.primary)
                    .padding(.horizontal, 4)
            }
        }
        .padding(.horizontal, 16)
        .frame(width: 361, height: 459)
    }
}


//#Preview {
//    ProductCardVBig()
//}
