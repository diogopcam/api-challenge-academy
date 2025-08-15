//
//  CategoryListView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//

import SwiftUI

struct CategoryListView: View {
    let apiCategories: [String]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(apiCategories, id: \.self) { apiCategory in
                    CategoryList(apiCategoryName: apiCategory)
                    
                    if apiCategory != apiCategories.last {
                        Divider()
                    }
                }
            }
        }
    }
}
