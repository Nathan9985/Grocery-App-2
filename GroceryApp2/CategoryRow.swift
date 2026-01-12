//
//  CategoryRow.swift
//  GroceryApp2
//
//  Created by Nathaniel Ruiz on 1/12/26.
//

import SwiftUI

struct CategoryRow: View {
    
    var categoryName: String
    
    var body: some View {
        HStack {
            Text("Category")
            Spacer()
            Text(categoryName)
        }
    }
}

#Preview {
    CategoryRow(categoryName: "Dairy")
}
