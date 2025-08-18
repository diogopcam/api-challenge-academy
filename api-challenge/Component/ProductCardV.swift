//
//  ProductCardV.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 14/08/25.
//

import SwiftUI
import SwiftData


    //@Environment(\.modelContext) private var modelContext
   // @State private var favoritesVM: FavoritesViewModel

//    var body: some View {
//        VStack(alignment: .leading) {
//            ZStack(alignment: .topTrailing) {
////                Image(.placeholder)
////                    .resizable()
////                    .frame(width:161, height: 160)
////                    .cornerRadius(8)
//                AsyncImage(url: URL(string: product.thumbnail)) { phase in
//                    switch phase {
//                    case .empty:
//                        ProgressView()
//                            .frame(width: 161, height: 160)
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 161, height: 160)
//                            .clipped()
//                            .cornerRadius(8)
//                    case .failure:
//                        Image(systemName: "photo")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 161, height: 160)
//                            .foregroundColor(.gray)
//                    @unknown default:
//                        EmptyView()
//                    }
//                }
//                
//                Button {
//                    // ação do botão
//                } label: {
//                    Image(systemName: "heart")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .padding(8)
//                        .background(
//                            RoundedRectangle(cornerRadius: 8)
//                                .foregroundColor(Color(.systemGray5))
//                        )
//                        .foregroundStyle(.labelsPrimary)
//                }
//                .frame(width: 38, height: 38)
//            }
//            .padding(.horizontal, 8)
//            .padding(.top, 8)
//
//            VStack(alignment: .leading, spacing: 4) {
//                Text(product.title)
//                    .font(.system(size: 14,weight: .regular))
//                    .lineLimit(2)
//                    .foregroundStyle(.labelsPrimary)
//                    .multilineTextAlignment(.leading)
//                    //.frame(maxWidth: .infinity)
//
//                Text("US$ \(String(format: "%.2f", product.price))")
//                    .font(.system(.body, weight: .semibold))
//                    .foregroundStyle(.labelsPrimary)
//            }
//            .padding(.horizontal, 8)
//            .padding(.bottom, 8)
//            .frame(width: 177, height: 76)
//        }
//        .background(
//            RoundedRectangle(cornerRadius: 16)
//                .foregroundStyle(.backgroundsSecondary)
//        )
//    }

//    var body: some View {
//            VStack(alignment: .leading, spacing: 8) {
//                ZStack(alignment: .topTrailing) {
//                    AsyncImage(url: URL(string: product.thumbnail)) { image in
//                        image.resizable()
//                            .scaledToFill()
//                    } placeholder: {
//                        Image(.placeholder)
//                            .resizable()
//                            .scaledToFill()
//                    }
//                    .frame(width: 161, height: 160)
//                    .clipped()
//                    .cornerRadius(16)
//
//                    Button {
//                        favoritesVM.toggleFavorite(for: product)
//                    } label: {
//                        Image(systemName: favoritesVM.isFavorited(product: product) ? "heart.fill" : "heart")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                            .padding(8)
//                            .background(
//                                RoundedRectangle(cornerRadius: 8)
//                                    .foregroundColor(Color(.systemGray5))
//                            )
//                            .foregroundStyle(.labelsPrimary)
//                    }
//                    .padding(8)
//                }
//
//                VStack(alignment: .leading, spacing: 4) {
//                    Text(product.title)
//                        .font(.system(size: 14, weight: .semibold))
//                        .foregroundColor(.primary)
//                        .lineLimit(2)
//
//                    Text("R$ \(product.price, specifier: "%.2f")")
//                        .font(.system(size: 13))
//                        .foregroundColor(.secondary)
//                }
//                .padding(.horizontal, 8)
//                .padding(.bottom, 8)
//            }
//            .frame(width: 161)
//            .background(.backgroundsPrimary)
//            .cornerRadius(16)
//        }
//struct ProductCardV: View {
//        let product: ProductDTO
//        @ObservedObject var favoritesVM: FavoritesViewModel
//
//        var body: some View {
//            VStack(alignment: .leading, spacing: 8) {
//                ZStack(alignment: .topTrailing) {
//                    AsyncImage(url: URL(string: product.thumbnail)) { image in
//                        image.resizable()
//                            .scaledToFill()
//                    } placeholder: {
//                        Image(.placeholder)
//                            .resizable()
//                            .scaledToFill()
//                    }
//                    .frame(width: 161, height: 160)
//                    .clipped()
//                    .cornerRadius(16)
//
//                    Button {
//                        favoritesVM.toggleFavorite(for: product)
//                    } label: {
//                        Image(systemName: favoritesVM.isFavorited(product: product) ? "heart.fill" : "heart")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                            .padding(8)
//                            .background(
//                                RoundedRectangle(cornerRadius: 8)
//                                    .foregroundColor(Color(.systemGray5))
//                            )
//                            .foregroundStyle(.labelsPrimary)
//                    }
//                    .padding(8)
//                }
//
//                VStack(alignment: .leading, spacing: 4) {
//                    Text(product.title)
//                        .font(.system(size: 14, weight: .semibold))
//                        .foregroundColor(.primary)
//                        .lineLimit(2)
//
//                    Text("R$ \(product.price, specifier: "%.2f")")
//                        .font(.system(size: 13))
//                        .foregroundColor(.secondary)
//                }
//                .padding(.horizontal, 8)
//                .padding(.bottom, 8)
//            }
//            .frame(width: 161)
//            .background(.backgroundsPrimary)
//            .cornerRadius(16)
//        }
//    }

//struct ProductCardV: View {
//    let product: ProductDTO
//    @Query private var favorites: [CartItem]
//    @Environment(\.modelContext) private var modelContext
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            ZStack(alignment: .topTrailing) {
//                AsyncImage(url: URL(string: product.thumbnail)) { image in
//                    image.resizable().scaledToFill()
//                } placeholder: {
//                    Image(.placeholder).resizable().scaledToFill()
//                }
//                .frame(width: 161, height: 160)
//                .clipped()
//                .cornerRadius(16)
//
//                Button {
//                    toggleFavorite(for: product)
//                } label: {
//                    Image(systemName: isFavorited(product: product) ? "heart.fill" : "heart")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .padding(8)
//                        .background(
//                            RoundedRectangle(cornerRadius: 8)
//                                .foregroundColor(Color(.systemGray5))
//                        )
//                        .foregroundStyle(.labelsPrimary)
//                }
//                .padding(8)
//            }
//
//            VStack(alignment: .leading, spacing: 4) {
//                Text(product.title)
//                    .font(.system(size: 14, weight: .semibold))
//                    .foregroundColor(.primary)
//                    .lineLimit(2)
//
//                Text("R$ \(product.price, specifier: "%.2f")")
//                    .font(.system(size: 13))
//                    .foregroundColor(.secondary)
//            }
//            .padding(.horizontal, 8)
//            .padding(.bottom, 8)
//        }
//        .frame(width: 161)
//        .background(.backgroundsPrimary)
//        .cornerRadius(16)
//    }
//
//    private func isFavorited(product: ProductDTO) -> Bool {
//        favorites.contains { $0.id == product.id && $0.isFavorite }
//    }
//
//    private func toggleFavorite(for product: ProductDTO) {
//        if let item = favorites.first(where: { $0.id == product.id }) {
//            item.isFavorite.toggle()
//        } else {
//            let newItem = CartItem(from: product)
//            newItem.isFavorite = true
//            modelContext.insert(newItem)
//        }
//        try? modelContext.save()
//    }
//}


struct ProductCardV: View {
    let product: ProductDTO
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Product> { $0.isFavorite == true })
    private var favorites: [Product]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Image(.placeholder).resizable().scaledToFill()
                }
                .frame(width: 161, height: 160)
                .clipped()
                .cornerRadius(16)

                Button {
                    toggleFavorite()
                } label: {
                    Image(systemName: isFavorited() ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.systemGray5)))
                        .foregroundStyle(.labelsPrimary)
                }
                .padding(8)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(2)

                Text("R$ \(product.price, specifier: "%.2f")")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .frame(width: 161)
        .background(.backgroundsPrimary)
        .cornerRadius(16)
    }

    private func isFavorited() -> Bool {
            favorites.contains { $0.id == product.id }
        }

    private func toggleFavorite() {
            if let existing = favorites.first(where: { $0.id == product.id }) {
                existing.isFavorite = false
            } else {
                let newProduct = Product(from: product, type: .favorites)
                newProduct.isFavorite = true
                modelContext.insert(newProduct)
            }
            try? modelContext.save()
    }
}
