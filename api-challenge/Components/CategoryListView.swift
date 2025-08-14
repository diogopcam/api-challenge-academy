//
//  CategoryListView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//

import SwiftUI

struct CategoryListView: View {
    let categories: [String]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(categories, id: \.self) { category in
                    CategoryList(name: category)
                    
                    if category != categories.last {
                        Divider()
                    }
                }
            }
        }
    }
}

#Preview {
    CategoryListView(categories: ["Categoria 2", "Categoria 1", "Categoria 3"])
}
