//
//  ProductList.swift
//  api-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//

import SwiftUI

struct ProductList: View {
    
    let image: Image?
    let productName: String
    let price: Double
    @Binding var quantity: Int
    let variant: ProductListStyle
    
    private let cardWidth: CGFloat = 361
    private let cardHeight: CGFloat = 94
    private let cornerRadius: CGFloat = 16
    private let imageFrameSize: CGSize = CGSize(width: 78, height: 78)
    
    var body: some View {
        HStack(spacing: 16) {
            // Seção de Imagem (comum a todas as variações)
            imageSection
            
            // Seção de Texto (com tratamento para data de entrega)
            VStack(alignment: .leading, spacing: 4) {
                if case let .delivery(month, day) = variant {
                    deliveryDateText(month, day)
                }
                
                productNameText
                priceText
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Seção Dinâmica (stepper/carrinho)
            switch variant {
            case .stepper:
                stepperSection
            case .cart(let action):
                cartButtonSection(action: action)
            case .delivery:
                EmptyView()
            }
        }
        .padding(.leading, 8)
        .padding(.trailing, 16)
        .frame(width: cardWidth, height: cardHeight)
        .background(.backgroundsSecondary)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
    // MARK: - Subviews
    
    private var imageSection: some View {
        Group {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageFrameSize.width, height: imageFrameSize.height)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Image("Placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageFrameSize.width, height: imageFrameSize.height)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .background(.backgroundsSecondary)
            }
        }
    }
    
    private func deliveryDateText(_ month: String, _ day: String) -> some View {
        Text("DELIVERY BY \(month), \(day)")
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.labelsSecondary)
    }
    
    private var productNameText: some View {
        Text(productName)
            .font(.system(size: 13, weight: .regular))
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
            .foregroundColor(.labelsPrimary)
    }
    
    private var priceText: some View {
        Text(formattedPrice)
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(.labelsPrimary)
    }
    
    private var stepperSection: some View {
        HStack(spacing: 8) {
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
            .buttonStyle(PlainButtonStyle())
            
            Text("\(quantity)")
                .font(.system(size: 17, weight: .regular))
                .frame(width: 21)
                .monospacedDigit()
            
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
        .fixedSize()
    }
    
    private func cartButtonSection(action: @escaping () -> Void) -> some View {
        Button(
            // Inserir aqui a ação de inserir o produto no carrinho
            action: action
        ) {
            Image(systemName: "cart.fill")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.labelsPrimary)
                .frame(width: 38, height: 38)
                .background(.fillsTertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
}

// MARK: - Previews
struct ProductList_Previews: PreviewProvider {
    struct InteractivePreview: View {
        @State private var quantity = 2
        
        var body: some View {
            VStack(spacing: 20) {
                // Variação com Stepper (agora funcional)
                ProductList(
                    image: Image(systemName: "photo"), // SF Symbol correta
                    productName: "Product name with two or more lines goes here",
                    price: 12.99,
                    quantity: $quantity, // Binding real
                    variant: .stepper
                )
                
                // Debug: Mostra o valor atual em tempo real
                Text("Quantidade atual: \(quantity)")
                    .font(.headline)
                    .padding()
                
                // Outras variações...
                ProductList(
                    image: Image(systemName: "photo"), // SF Symbol correta
                    productName: "Product name with two or more lines goes here",
                    price: 7.49,
                    quantity: .constant(0),
                    variant: .cart {
                        print("Produto adicionado ao carrinho")
                    }
                )
                
                // Exemplo de uso com data separada
                ProductList(
                    image: nil,
                    productName: "Produto Teste",
                    price: 29.99,
                    quantity: .constant(1),
                    variant: .delivery(month: "DECEMBER", day: "25")
                )
            }
            .padding()
        }
    }
    
    static var previews: some View {
        InteractivePreview()
    }
}
