//
//  ProductListAsyncImage.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 17/08/25.
//

import SwiftUI
import SwiftData

struct ProductListAsyncImage: View {
    let thumbnailURL: String?
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
            imageSection

            VStack(alignment: .leading, spacing: 4) {
                if case let .delivery(month, day) = variant {
                    Text("DELIVERY BY \(month), \(day)")
                        .font(.system(size: 12))
                        .foregroundColor(.labelsSecondary)
                }

                Text(productName)
                    .font(.system(size: 13))
                    .foregroundColor(.labelsPrimary)

                Text(formattedPrice)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.labelsPrimary)
            }

            Spacer()

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
            }
        }
    }

    private var stepperSection: some View {
        HStack(spacing: 8) {
            Button {
                if quantity > 0 { quantity -= 1 }
            } label: {
                Image(systemName: "minus")
                    .font(.system(size: 12))
                    .frame(width: 23, height: 23)
                    .background(.fillsQuaternary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            Text("\(quantity)")
                .font(.system(size: 17))
                .frame(width: 21)

            Button {
                quantity += 1
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 12))
                    .frame(width: 23, height: 23)
                    .background(.fillsQuaternary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
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
        }
    }

    private var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
}
