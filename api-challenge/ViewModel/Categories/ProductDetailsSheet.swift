//
//  ProductDetailsSheet.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 15/08/25.
//

import SwiftUI
import SwiftData

struct ProductDetailsSheet: View {
    let product: ProductDTO
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            Text("Details")
                .font(.system(size: 17, weight: .semibold))
                .padding(.top, 20)

            ScrollView {
                VStack(spacing: 16) {
                    ProductCardVBig(product: product)
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity)

                    Text(product.description)
                        .padding()
                        .frame(width: 361, alignment: .leading)
                        .foregroundStyle(.labelsSecondary)
                        .cornerRadius(8)
                }
                .padding(.bottom, 20)
            }

            Button(action: {
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
    }
}



//#Preview {
//    ProductDetailsSheet()
//}
