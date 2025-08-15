//
//  ProductCardH.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 14/08/25.
//

import SwiftUI

struct ProductCardH: View {
    
    var body: some View {
        HStack {
            HStack (spacing: 8){
                HStack {
                    Image(.placeholder)
                        .resizable()
                        .frame(width: 160, height: 160)
                        .cornerRadius(16)
                }
                .padding(.vertical, 8)
                .padding(.leading, 8)
                .padding(.trailing)
                VStack() {
                    VStack (alignment: .leading, spacing: 32) {
                        HStack() {
                            Text("CATEGORY")
                                .foregroundStyle(.labelsSecondary)
                            Spacer()
                            // Botão favorito no topo direito
                            Button {
                            // ação do botão
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
                            Text("Product name with two\nor more lines goes here.")
                                .foregroundStyle(.labelsPrimary)
                                
                            Text("US$ 00,00")
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
    

#Preview {
    ProductCardH()
}
