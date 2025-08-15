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
        HStack {
            HStack (spacing: 8){
                HStack {
//                    AsyncImage(url: URL(string: product.thumbnail)) { image in
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                    } placeholder: {
//                        Color.gray.opacity(0.2)
//                    }
                    AsyncImage(url: URL(string: product.thumbnail)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }  placeholder: {
                        Image(.placeholder)
                            .resizable()
                            .frame(width: 160, height: 160)
                            .cornerRadius(16)
                    }
                }
                .padding(.vertical, 8)
                .padding(.leading, 8)
                .padding(.trailing)
                VStack() {
                    VStack (alignment: .leading, spacing: 32) {
                        HStack() {
                            Text(product.category)
                                .foregroundStyle(.labelsSecondary)
                            Spacer()
                            
                            Button {
                            
                            } label: {
                                Image(systemName: "heart")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(9)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(Color(.systemGray5))
                                    )
                            }
                            .frame(width: 38, height: 38)
                            .padding(.trailing, 8)
                        }
                        VStack (alignment: .leading,spacing: 4) {
                            Text(product.title)
                                .foregroundStyle(.labelsPrimary)
                                
                            Text("US$ \(product.price)")
                                .font(.system(.body, weight: .semibold))
                                .foregroundStyle(.labelsPrimary)
                        }
                        .padding(.trailing, 8)
                            
                    }

                }
            }
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.backgroundsSecondary)
            )
        }
    }
}
    

//#Preview {
//    ProductCardH()
//}
