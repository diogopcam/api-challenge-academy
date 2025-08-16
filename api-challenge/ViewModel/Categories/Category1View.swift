//
//  Category1View.swift
//  api-challenge
//
//  Created by Eduardo Ferrari on 15/08/25.
//

import SwiftUI

struct Category1View: View {
    let categoryName: String
    @State private var searchText: String = ""
    @State private var showSheet = false

    var body: some View {
        List {
            Section {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 8),
                    GridItem(.flexible(), spacing: 8)
                ], spacing: 8) {
                    ForEach(0..<20, id: \.self) { _ in
                        ProductCardV()
                            .onTapGesture {
                                showSheet = true
                            }
                            .listRowInsets(EdgeInsets())
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .listStyle(.plain)
        .navigationTitle(categoryName)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Search...")
        .sheet(isPresented: $showSheet) {
            ProductDetailsSheet()
        }
    }
}

//#Preview {
//    Category1View()
//}
