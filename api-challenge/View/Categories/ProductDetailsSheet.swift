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
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    // Serviços necessários
    private var userProductsService: UserProductsService {
        UserProductsService(context: context)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Details")
                .font(.system(size: 17, weight: .semibold))
                .padding(.top, 20)
            
            ScrollView {
                VStack(spacing: 16) {
                    // ProductCardVBig precisa ser adaptado para usar o novo sistema
                    ProductCardVBig(product: product)
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity)
                    
                    Text(product.description)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.labelsSecondary)
                        .cornerRadius(8)
                }
                .padding(.bottom, 20)
            }
            
            Button(action: {
                addToCart()
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
    
    private func addToCart() {
        do {
            try userProductsService.addToCart(product)
        } catch {
            print("Erro ao adicionar ao carrinho: \(error)")
        }
    }
}
