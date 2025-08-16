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
        
    var body: some View {
        
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(apiCategories, id: \.self) { apiCategory in
                    
                    NavigationLink(destination: Category1View(categoryName: apiCategory)) {
                        
                        CategoryList(apiCategoryName: apiCategory)
                    }
                }
            }
        }
    }

}
#Preview {
   TabBar()
}

//if apiCategory != apiCategories.last {
//    Divider()
//}
