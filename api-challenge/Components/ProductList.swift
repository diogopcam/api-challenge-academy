//
//  ProductList.swift
//  api-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//


import SwiftUI

struct ProductList: View {
    let image: Image
    let productName: String
    let price: Double
    @Binding var quantity: Int
    
    private let cardWidth: CGFloat = 361
    private let cardHeight: CGFloat = 94
    private let imageSize: CGFloat = 78
    private let cornerRadius: CGFloat = 16
    
    var body: some View {
        HStack(spacing: 12) {
            // Product Image
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: imageSize, height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Product Info
            VStack(alignment: .leading, spacing: 4) {
                Text(productName)
                    .font(.system(size: 16, weight: .medium))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                
                Text(formattedPrice)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Quantity Stepper
            // Custom Stepper with visible quantit
            HStack(spacing: 16) {
                // Botão de diminuir (-)
                Button {
                    if quantity > 0 { quantity -= 1 }
                } label: {
                    Image(systemName: "minus")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.black)
                        .frame(width: 23, height: 23)
                        .background(.fillsQuaternary)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .disabled(quantity <= 0)
                .buttonStyle(PlainButtonStyle()) // Remove todos os efeitos visuais
                
                Text("\(quantity)")
                    .font(.system(size: 17, weight: .regular))
                
                Button {
                    quantity += 1
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.black)
                        .frame(width: 23, height: 23)
                        .background(.fillsQuaternary)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(12)
        .frame(width: cardWidth, height: cardHeight)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    private var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
}

#Preview {
    VStack(spacing: 20) {
        // Preview 1: Basic product with default quantity
        ProductList(
            image: Image(systemName: "bag.fill"),
            productName: "Organic Coffee Beans",
            price: 12.99,
            quantity: .constant(1)
        )
        
        // Preview 2: Product with long name
        ProductList(
            image: Image(systemName: "leaf.fill"),
            productName: "Premium Organic Avocado - Pack of 4 Large Fruits",
            price: 7.49,
            quantity: .constant(2)
        )
        
        // Preview 3: Product with zero quantity
        ProductList(
            image: Image(systemName: "cart.fill"),
            productName: "Whole Grain Bread",
            price: 3.99,
            quantity: .constant(0)
        )
        
        // Preview 4: High price product
        ProductList(
            image: Image(systemName: "dumbbell.fill"),
            productName: "Professional Dumbbell Set",
            price: 129.99,
            quantity: .constant(1)
        )
    }
    .padding()
}

