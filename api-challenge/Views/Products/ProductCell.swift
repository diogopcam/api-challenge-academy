//
//  ProductCell.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 17/08/25.
//

import SwiftUI
import SwiftData

struct ProductCell: View {
    @Binding var quantity: Int
    let thumbnailURL: String?
    let productName: String
    let price: Double
    let variant: ProductListStyle
    let dateOrdered: Date?
    
    private var deliveryInfo: DeliveryInfo? {
        guard let date = dateOrdered else { return nil }
        return DeliveryInfo(from: date)
    }

    private let cardWidth: CGFloat = 361
    private let cardHeight: CGFloat = 94
    private let cornerRadius: CGFloat = 16
    private let imageFrameSize: CGSize = CGSize(width: 78, height: 78)
    
    // Inicializador só para order/delivery
    init(image: String?, productName: String, price: Double, variant: ProductListStyle, dateOrdered: Date) {
        self.thumbnailURL = image
        self.productName = productName
        self.price = price
        self._quantity = .constant(0)
        self.variant = variant
        self.dateOrdered = dateOrdered
    }
    
    init(image: String?, productName: String, price: Double, quantity: Binding<Int>, variant: ProductListStyle) {
        self.thumbnailURL = image
        self.productName = productName
        self.price = price
        self._quantity = quantity
        self.variant = variant
        self.dateOrdered = nil
    }

    var body: some View {
        HStack(spacing: 16) {
            imageSection

            VStack(alignment: .leading, spacing: 4) {
                
                if case .delivery = variant, let date = dateOrdered {
                    let deliveryInfo = DeliveryInfo(from: date)
                    Text(deliveryInfo.displayText)
                        .font(.system(size: 12))
                        .foregroundColor(.labelsSecondary)
                }
                
                Text(productName)
                    .font(.system(size: 13))
                    .foregroundColor(.labelsPrimary)

                Text(formattedPriceString)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.labelsPrimary)
            }

            Spacer()

            switch variant {
                case .stepper(let onIncrement, let onDecrement):
                    stepperSection(onIncrement: onIncrement, onDecrement: onDecrement)
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
        .accessibilityElement(children: .contain)
        .accessibilityLabel(String(format: NSLocalizedString("%@, price %@", comment: ""), productName, formattedPriceString, "The product was delivered on"))
    }

    private var imageSection: some View {
        Group {
            if let urlString = thumbnailURL, let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: imageFrameSize.width, height: imageFrameSize.height)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: imageFrameSize.width, height: imageFrameSize.height)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .accessibilityHint(NSLocalizedString("This is the image representing the product", comment: ""))
                    case .failure(_):
                        Image("Placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imageFrameSize.width, height: imageFrameSize.height)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image("Placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageFrameSize.width, height: imageFrameSize.height)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .background(.backgroundsSecondary)
                    .accessibilityHint(NSLocalizedString("This product does not have an available image", comment: ""))
            }
        }
    }

    private func stepperSection(onIncrement: @escaping () -> Void, onDecrement: @escaping () -> Void) -> some View {
        HStack(spacing: 8) {
            Button {
                onDecrement()
            } label: {
                Image(systemName: "minus")
                    .font(.system(size: 12))
                    .frame(width: 23, height: 23)
                    .background(.fillsQuaternary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(.labelsPrimary)
                    .accessibilityHint(NSLocalizedString("Press to remove one unit of this product from your cart", comment: ""))
            }

            Text("\(quantity)")
                .font(.system(size: 17))
                .frame(width: 21)
                .accessibilityHint(String(format: NSLocalizedString("There are %lld units of this product in your cart", comment: ""), quantity))

            Button {
                onIncrement()
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 12))
                    .frame(width: 23, height: 23)
                    .background(.fillsQuaternary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(.labelsPrimary)
                    .accessibilityHint(NSLocalizedString("Press to add one more unit of this product to your cart", comment: ""))
            }
        }
    }

    private func cartButtonSection(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: "cart.fill")
                .font(.system(size: 16))
                .foregroundColor(.labelsPrimary)
                .frame(width: 38, height: 38)
                .background(.fillsTertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .accessibilityHint(String(format: NSLocalizedString("Press to check the information of product %@", comment: ""), productName))
        }
    }
    
    private var formattedPriceString: String {
        let format = NSLocalizedString("price_format", comment: "Format string for product price")
        return String(format: format, price)
    }
}
