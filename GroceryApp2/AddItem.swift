//
//  AddItem.swift
//  GroceryApp2
//
//  Created by Nathaniel Ruiz on 1/8/26.
//

/*
 * TODO: Want to have Add Item take you back to main menu or refresh this screen?
 *       Allow user to create own categories
 *       Allow user to select from previously saved items and automatically calculate
 *           best by date
 */

import SwiftUI

struct AddItem: View {
    
    @ObservedObject var groceryItems: GroceryItems
    
    // Variables to build new GroceryItem object from
    @State private var selectedName: String = ""
    @State private var selectedCategory: Category = .None
    @State private var selectedBestby: Date = Date()
    
    var body: some View {
        // Gather the Name, Category, and Best By date of new item,
        // then add it to the underlying object of GroceryItems
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
            
            DatePicker("Best By", selection: $selectedBestby, displayedComponents: [.date])
            
            Button(
                "Add Item",
                action: {
                    groceryItems.items.append(GroceryItem(name: self.selectedName, category: self.selectedCategory, bestby: self.selectedBestby))
                }
            )
        }
    }
}

#Preview {
    AddItem(groceryItems: GroceryItems(items: [GroceryItem(name: "Apple", category: Category.Produce, bestby: createDate(year: 2026, month: 1, day: 16))]))
}
