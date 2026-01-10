//
//  AddSavedItem.swift
//  GroceryApp2
//
//  Created by Nathaniel Ruiz on 1/9/26.
//

import SwiftUI

struct AddSavedItem: View {
    @ObservedObject var savedItems: SavedItems
    
    // Variables to build new SavedItem object from
    @State private var selectedName: String = ""
    @State private var selectedCategory: Category = .None
    @State private var selectedLifespan: Int?
    
    @Environment(\.dismiss) private var dismiss
    
    private let lifespanFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.allowsFloats = false
        formatter.minimum = 0
        return formatter
    }()
    
    var body: some View {
        // Gather the Name, Category, and Lifespan of new item,
        // then add it to the underlying object of SavedItems
        NavigationView {
            Form {
                TextField(
                    "Item Name",
                    text: $selectedName
                )
                
                Picker("Category", selection: $selectedCategory) {
                    ForEach(Category.allCases, id: \.self) { category in
                        Text(category.rawValue)
                    }
                }
                
                TextField(
                    "Lifespan",
                    value: $selectedLifespan,
                    formatter: lifespanFormatter
                )
                
                Button(
                    "Add Item",
                    action: {
                        if (selectedLifespan == nil) {
                            savedItems.items.append(SavedItem(name: self.selectedName, category: self.selectedCategory, lifespan: 0))
                        } else {
                            savedItems.items.append(SavedItem(name: self.selectedName, category: self.selectedCategory, lifespan: self.selectedLifespan!))
                        }
                        dismiss()
                    }
                )
            }
            .navigationTitle("Save Item")
        }
    }
}

#Preview {
    AddSavedItem(savedItems: SavedItems(items: [SavedItem(name: "Apple", category: .Produce, lifespan: 12)]))
}
