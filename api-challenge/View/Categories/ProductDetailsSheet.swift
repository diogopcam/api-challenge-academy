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
        NavigationStack {
            VStack {
                VStack (spacing: 8){
                    Capsule()
                        .frame(width: 40, height: 5)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.top, 8)
                    Text("Details")
                        Divider()
                        .font(.system(size: 17, weight: .semibold))
                }
                .frame(width: 393, height: 54)
                .background(.fillsTertiary)
                ScrollView{
                    VStack {
                        ProductCardVBig(product: product)
                    }
                    Text(product.description)
                        .foregroundColor(.secondary)
                    }
                .padding(.horizontal)

                Button("Add to cart") {
                    addToCart()
                    dismiss()
                }
                .foregroundStyle(.labelsPrimary)
                .frame(height: 54)
                .frame(maxWidth: .infinity)
                .background(.fillsTertiary)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
            .background(.backgroundsPrimary)
        }
        .toolbarBackground(.backgroundsTertiary, for: .navigationBar)
              .toolbarBackground(.visible, for: .navigationBar)
              .onAppear {
//                  cartVM = CartViewModel(context: context)
//                  favoritesVM = FavoritesViewModel(context: context)
              }
          }

    private func addToCart() {
        do {
            try userProductsService.addToCart(product)
        } catch {
            print("Erro ao adicionar ao carrinho: \(error)")
        }
    }
}
