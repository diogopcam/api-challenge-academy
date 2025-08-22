//
//  CategoryListView.swift
//  api-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//

import SwiftUI
import SwiftData

struct CategoryListView: View {
    let apiCategories: [String]
    var onTapCategory: ((String) -> Void)?  // closure opcional para tratar tap
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(apiCategories, id: \.self) { apiCategory in
                    CategoryList(
                        apiCategoryName: apiCategory,
                        onTap: {
                            onTapCategory?(apiCategory)
                        }
                    )
                }
            }
        }
    }
}
