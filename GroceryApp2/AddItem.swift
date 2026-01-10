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

// Enum for Picker control
private enum ViewSelection: String, CaseIterable {
    case Saved = "From Saved"
    case New = "From New"
    
    var title: String {
        return self.rawValue
    }
}

struct AddItem: View {
    @ObservedObject var groceryItems: GroceryItems
    @ObservedObject var savedItems: SavedItems
    
    // Keep track of which add view should be displayed
    @State private var selectedView: ViewSelection = .Saved
    
    var body: some View {
        // Change views depending on add method
        // If one off, new item, display FromNewView and pass on groceryItems
        // If adding from saved items, dispaly SavedItemsView
        VStack{
            Picker("Add method", selection: $selectedView) {
                ForEach(ViewSelection.allCases, id:\.self) { selection in
                    Text(selection.title)
                }
            }
            .pickerStyle(.segmented)
            
            switch selectedView {
            case .New:
                FromNewView(groceryItems: self.groceryItems)
            case .Saved:
                SavedItemsView(savedItems: self.savedItems, groceryItems: self.groceryItems)
            }
        }
    }
}

struct FromNewView: View {
    
    @ObservedObject var groceryItems: GroceryItems
    
    // Variables to build new GroceryItem object from
    @State private var selectedName: String = ""
    @State private var selectedCategory: Category = .None
    @State private var selectedBestby: Date = Date()
    
    // Deal with dismissing this view and going back to home page
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
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
                
                DatePicker("Best By", selection: $selectedBestby, displayedComponents: [.date])
                
                Button(
                    "Add Item",
                    action: {
                        groceryItems.items.append(GroceryItem(name: self.selectedName, category: self.selectedCategory, bestby: self.selectedBestby))
                        dismiss()
                    }
                )
            }
            .navigationTitle("Add Item")
        }
    }
}

#Preview {
    AddItem(groceryItems: GroceryItems(items: [GroceryItem(name: "Apple", category: Category.Produce, bestby: createDate(year: 2026, month: 1, day: 16))]), savedItems: SavedItems(items: [SavedItem(name: "Salmon", category: .Meat, lifespan: 5)]))
}
