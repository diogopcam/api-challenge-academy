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
//                Image(.placeholder)
//                    .resizable()
//                    .frame(width:161, height: 160)
//                    .cornerRadius(8)
                AsyncImage(url: URL(string: product.thumbnail)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 161, height: 160)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 161, height: 160)
                            .clipped()
                            .cornerRadius(8)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 161, height: 160)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Button {
                    // ação do botão
                } label: {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color(.systemGray5))
                        )
                        .foregroundStyle(.labelsPrimary)
                }
                .frame(width: 38, height: 38)
            }
            .padding(.horizontal, 8)
            .padding(.top, 8)

            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.system(size: 14,weight: .regular))
                    .lineLimit(2)
                    .foregroundStyle(.labelsPrimary)
                    .multilineTextAlignment(.leading)
                    //.frame(maxWidth: .infinity)

                Text("US$ \(String(format: "%.2f", product.price))")
                    .font(.system(.body, weight: .semibold))
                    .foregroundStyle(.labelsPrimary)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
            .frame(width: 177, height: 76)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundsSecondary)
        )
    }
}


//#Preview {
//    ProductCardV()
//}
