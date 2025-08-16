//
//  ProductDetailsSheet.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 15/08/25.
//

import SwiftUI

struct ProductDetailsSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var text: String = "hgfjhwegdejhwgdjhewgdjehwgjhewgdjhewgdjhewgdhjewghdjgewjdgewhjdgewjhdghjewgdjhewdgjehwdewgdhjewgdjhgewjhdghjewdgewjhdghwedjwehjdg"
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Título
            Text("Details")
                .font(.system(size: 17, weight: .semibold))
                .padding(.top, 20)
            
            ScrollView {
                VStack(spacing: 16) {
                    ProductCardVBig()
                        //.frame(width: 361, height: 459)
                        .padding(.top, 16)
                       // .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                    TextEditor(text: $text)
                        .frame(width: 361, height: 459)
                        
                }
                .padding(.bottom, 20) // para não colar no botão
                
            }
            Button(action: {
                // ação do botão
                dismiss()
            }) {
                Text("Add to cart")
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(.fillsTertiary)
                    .foregroundColor(.labelsPrimary)
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
            }
            .background(.backgroundsPrimary)
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
//        .navigationBarTitle("Details")
//        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    ProductDetailsSheet()
}
