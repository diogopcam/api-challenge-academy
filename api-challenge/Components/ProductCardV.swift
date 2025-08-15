//
//  ProductCardV.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 14/08/25.
//

import SwiftUI

struct ProductCardV: View {
    var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .topTrailing) {
                    Image(.placeholder)
                        .resizable()
                        //.scaledToFill()
                        .frame(width:161, height: 160)
                        //.frame(maxWidth: .infinity)
                        //.clipped()
                        .cornerRadius(8)

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
                    }
                    .frame(width: 38, height: 38)
                    
                }
                .padding(.horizontal, 8)
                .padding(.top, 8)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Product name with two\nor more lines goes here")
                        .font(.body)
                        .foregroundStyle(.labelsPrimary)
                    
                    Text("US$ 00.00")
                        .font(.system(.body, weight: .semibold))
                        .foregroundStyle(.labelsPrimary)
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 12)
            }
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.backgroundsSecondary)
            )
            .frame(width: 177, height: 250)
        }
}

#Preview {
    ProductCardV()
}
