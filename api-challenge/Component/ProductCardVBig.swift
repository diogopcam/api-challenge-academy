//
//  ProductCardVBig.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 15/08/25.
//

import SwiftUI

struct ProductCardVBig: View {
    var body: some View {
           VStack(alignment: .leading, spacing: 16) {
               VStack {
                   ZStack(alignment: .topTrailing) {
                       Image(.placeholder)
                           .resizable()
                           .scaledToFill()
                           .frame(width: 329, height: 329)
                           .clipped()
                           .cornerRadius(16)

                       Button(action: {
                           // ação do botão
                       }) {
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
                   .frame(width: 329, height: 329)
                   
               }
               .frame(width: 361, height: 361)
               .background(
                   RoundedRectangle(cornerRadius: 16)
                       .foregroundStyle(.backgroundsSecondary)
               )
               

               VStack(alignment: .leading, spacing: 8) {
                   Text("Name of a product with two or more lines goes here")
                       .font(.system(size: 20, weight: .regular))
                       .foregroundColor(.primary)
                       .multilineTextAlignment(.leading)
                       .lineLimit(2)
                       .frame(height: 50)
                       .padding(.horizontal,4)

                   Text("US$ 00.00")
                       .font(.system(size: 25, weight: .semibold))
                       .foregroundColor(.primary)
                       .padding(.horizontal,4)
               }
           }
           .padding(.horizontal, 16) // <- aplica margem simétrica nos dois lados
           .frame(width: 361, height: 459)
       }
}

#Preview {
    ProductCardVBig()
}
