//
//  ProductCardVBig.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 15/08/25.
//

import SwiftUI
import SwiftData

//struct ProductCardVBig: View {
//    let product: ProductDTO
//    @Environment(\.modelContext) private var modelContext
//       @State private var favoritesVM: FavoritesViewModel = .init(context: .init())
//
////    var body: some View {
////        VStack(alignment: .leading, spacing: 16) {
////            ZStack(alignment: .topTrailing) {
//////                Image(.placeholder)
//////                    .resizable()
//////                    .scaledToFill()
//////                    .frame(width: 329, height: 329)
//////                    .clipped()
//////                    .cornerRadius(16)
////                AsyncImage(url: URL(string: product.thumbnail)) { phase in
////                    switch phase {
////                    case .empty:
////                        ProgressView()
////                            .frame(width: 329, height: 329)
////                    case .success(let image):
////                        image
////                            .resizable()
////                            .scaledToFill()
////                            .frame(width: 329, height: 329)
////                            .clipped()
////                            .cornerRadius(16)
////                    case .failure:
////                        Image(systemName: "photo")
////                            .resizable()
////                            .scaledToFit()
////                            .frame(width: 329, height: 329)
////                            .foregroundColor(.gray)
////                    @unknown default:
////                        EmptyView()
////                    }
////                }
////
////
////                Button(action: {}) {
////                    Image(systemName: "heart")
////                        .resizable()
////                        .frame(width: 35, height: 34)
////                        .padding(8)
////                        .background(
////                            RoundedRectangle(cornerRadius: 8)
////                                .foregroundColor(Color(.systemGray5))
////                        )
////                        .foregroundStyle(.labelsPrimary)
////                }
////                .frame(width: 51, height: 51)
////            }
////
////            VStack(alignment: .leading, spacing: 8) {
////                Text(product.title)
////                    .font(.system(size: 20, weight: .regular))
////                    .foregroundColor(.primary)
////                    .lineLimit(2)
////                    .frame(height: 50)
////                    .padding(.horizontal, 4)
////
////                Text("US$ \(String(format: "%.2f", product.price))")
////                    .font(.system(size: 25, weight: .semibold))
////                    .foregroundColor(.primary)
////                    .padding(.horizontal, 4)
////            }
////        }
////        .padding(.horizontal, 16)
////        .frame(width: 361, height: 459)
////    }
//    
//    var body: some View {
//            VStack(alignment: .leading, spacing: 8) {
//                ZStack(alignment: .topTrailing) {
//                    AsyncImage(url: URL(string: product.thumbnail)) { image in
//                        image.resizable()
//                            .scaledToFit()
//                    } placeholder: {
//                        Image(.placeholder)
//                            .resizable()
//                            .scaledToFit()
//                    }
//                    .frame(height: 240)
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
//                    .padding(12)
//                }
//
//                Text(product.title)
//                    .font(.title3)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.primary)
//                    .lineLimit(2)
//
//                Text("R$ \(product.price, specifier: "%.2f")")
//                    .font(.headline)
//                    .foregroundColor(.secondary)
//            }
//            .padding(.horizontal, 16)
//        }
//    
//    
//    
//    
//}

//struct ProductCardVBig: View {
//    let product: ProductDTO
//    @ObservedObject var favoritesVM: FavoritesViewModel
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            ZStack(alignment: .topTrailing) {
//                AsyncImage(url: URL(string: product.thumbnail)) { image in
//                    image.resizable()
//                        .scaledToFit()
//                } placeholder: {
//                    Image(.placeholder)
//                        .resizable()
//                        .scaledToFit()
//                }
//                .frame(height: 240)
//                .cornerRadius(16)
//
//                Button {
//                    favoritesVM.toggleFavorite(for: product)
//                } label: {
//                    Image(systemName: favoritesVM.isFavorited(product: product) ? "heart.fill" : "heart")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .padding(8)
//                        .background(
//                            RoundedRectangle(cornerRadius: 8)
//                                .foregroundColor(Color(.systemGray5))
//                        )
//                        .foregroundStyle(.labelsPrimary)
//                }
//                .padding(12)
//            }
//
//            Text(product.title)
//                .font(.title3)
//                .fontWeight(.semibold)
//                .foregroundColor(.primary)
//                .lineLimit(2)
//
//            Text("R$ \(product.price, specifier: "%.2f")")
//                .font(.headline)
//                .foregroundColor(.secondary)
//        }
//        .padding(.horizontal, 16)
//    }
//}

//struct ProductCardVBig: View {
//    let product: ProductDTO
//    @Query private var favorites: [CartItem]
//    @Environment(\.modelContext) private var modelContext
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            ZStack(alignment: .topTrailing) {
//                AsyncImage(url: URL(string: product.thumbnail)) { image in
//                    image.resizable().scaledToFit()
//                } placeholder: {
//                    Image(.placeholder).resizable().scaledToFit()
//                }
//                .frame(height: 240)
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
//                .padding(12)
//            }
//
//            Text(product.title)
//                .font(.title3)
//                .fontWeight(.semibold)
//                .foregroundColor(.primary)
//                .lineLimit(2)
//
//            Text("R$ \(product.price, specifier: "%.2f")")
//                .font(.headline)
//                .foregroundColor(.secondary)
//        }
//        .padding(.horizontal, 16)
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


struct ProductCardVBig: View {
    let product: ProductDTO
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Product> { $0.isFavorite == true })
    private var favorites: [Product]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    Image(.placeholder).resizable().scaledToFit()
                }
                .frame(width: 329, height: 329)
                .cornerRadius(16)

                Button {
                    toggleFavorite()
                } label: {
                    Image(systemName: isFavorited() ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 35, height: 34)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.systemGray5)))
                        .foregroundStyle(.labelsPrimary)
                }
                .padding(12)
            }

            Text(product.title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .lineLimit(2)

            Text("R$ \(product.price, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 16)
        .frame(width: 361, height: 459)
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




//#Preview {
//    ProductCardVBig()
//}
