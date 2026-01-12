//
//  SavedItemRow.swift
//  GroceryApp2
//
//  Created by Nathaniel Ruiz on 1/9/26.
//

import SwiftUI

// How to display a single row within SavedItem's List
struct SavedItemRow: View {
    
    @ObservedObject var savedItem: SavedItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2.0) {
            HStack {
                Text(savedItem.name)
                    .font(.title)
                Spacer()
                Text("\(savedItem.lifespan) days")
                    .font(.title2)
            }
            HStack {
                Text(savedItem.category)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    SavedItemRow(savedItem: SavedItem(name: "Apple", category: "Fruit", lifespan: 5))
}
