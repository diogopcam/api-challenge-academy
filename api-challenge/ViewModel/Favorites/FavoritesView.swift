//
//  FavoritesView.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 17/08/25.
//


import SwiftData
import SwiftUI

//struct FavoritesView: View {
//    @Environment(\.modelContext) private var modelContext
//    @State private var favoritesVM: FavoritesViewModel = .init(context: .init())
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(spacing: 16) {
//                    if favoritesVM.favorites.isEmpty {
//                        EmptyStateFav()
//                    } else {
//                        ForEach(favoritesVM.favorites, id: \.id) { item in
//                            ProductList(
//                                image: AsyncImage(url: URL(string: item.thumbnail), content: { image in
//                                    image.resizable()
//                                }, placeholder: {
//                                    ProgressView()
//                                }),
//                                productName: item.title,
//                                price: item.price,
//                                quantity: .constant(1),
//                                variant: .cart(action: {})
//                            )
//                        }
//                    }
//                }
//                .padding()
//            }
//            .navigationTitle("Favorites")
//        }
//        .onAppear {
//            favoritesVM = FavoritesViewModel(context: modelContext)
//        }
//    }
//}

//struct FavoritesView: View {
//    @Environment(\.modelContext) private var modelContext
//    @StateObject private var favoritesVM: FavoritesViewModel = .init(context: .init())
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(spacing: 16) {
//                    if favoritesVM.favorites.isEmpty {
//                        EmptyStateFav()
//                    } else {
//                        ForEach(favoritesVM.favorites, id: \.id) { item in
//                            ProductList(
//                                image: AsyncImage(url: URL(string: item.thumbnail), content: { image in
//                                    image.resizable()
//                                }, placeholder: {
//                                    ProgressView()
//                                }),
//                                productName: item.title,
//                                price: item.price,
//                                quantity: .constant(1),
//                                variant: .cart(action: {})
//                            )
//                        }
//                    }
//                }
//                .padding()
//            }
//            .navigationTitle("Favorites")
//        }
//        .onAppear {
//            favoritesVM.loadFavorites()
//        }
//    }
//}

//struct FavoritesView: View {
//    @Query private var favorites: [CartItem]
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(spacing: 16) {
//                    if favorites.filter({ $0.isFavorite }).isEmpty {
//                        EmptyStateFav()
//                    } else {
//                        ForEach(favorites.filter { $0.isFavorite }, id: \.id) { item in
//                            ProductList(
//                                image: AsyncImage(url: URL(string: item.thumbnail), content: { image in
//                                    image.resizable()
//                                }, placeholder: {
//                                    ProgressView()
//                                }),
//                                productName: item.title,
//                                price: item.price,
//                                quantity: .constant(1),
//                                variant: .cart(action: {})
//                            )
//                        }
//                    }
//                }
//                .padding()
//            }
//            .navigationTitle("Favorites")
//        }
//    }
//}

//struct FavoritesView: View {
//    @Query(filter: #Predicate<CartItem> { $0.isFavorite == true }) private var favorites: [CartItem]
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(spacing: 16) {
//                    if favorites.isEmpty {
//                        EmptyStateFav()
//                    } else {
//                        ForEach(favorites, id: \.self) { item in
//                            ProductList(
//                                image: nil,
//                                productName: item.name,
//                                price: item.price,
//                                quantity: .constant(1),
//                                variant: .cart(action: {})
//                            )
//                        }
//                    }
//                }
//                .padding()
//            }
//            .navigationTitle("Favorites")
//        }
//    }
//}

struct FavoritesView: View {
    @Environment(\.modelContext) private var context


    @Query(filter: #Predicate<Product> { $0.isFavorite == true })
    private var favoriteItems: [Product]
    
    var body: some View {
        if favoriteItems.isEmpty {
            NavigationStack {
                EmptyStateFav()
            }
            .navigationTitle("Favorites")
        } else {
            NavigationStack{
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(favoriteItems) { product in
                            ProductList(
                                image: nil,
                                productName: product.name,
                                price: product.price,
                                quantity: .constant(1),
                                variant: .cart {
                                    let cartVM = CartViewModel(context: context)
                                    cartVM.addToCart(ProductDTO(id: product.id, title: product.name, description: product.info, category: product.category, price: product.price, thumbnail: ""))
                                }
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Favorites")
        }
    }
}


