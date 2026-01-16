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
    case New = "Add New Item"
    case Saved = "My Saved Items"
    
    var title: String {
        return self.rawValue
    }
}

struct AddItem: View {
    @ObservedObject var groceryItems: GroceryItems
    @ObservedObject var savedItems: SavedItems
    @ObservedObject var savedCategories: Categories
    
    // Keep track of which add view should be displayed
    @State private var selectedView: ViewSelection = .New
    
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
                FromNewView(groceryItems: self.groceryItems, savedCategories: savedCategories)
            case .Saved:
                SavedItemsView(savedItems: self.savedItems, groceryItems: self.groceryItems, savedCategories: savedCategories)
            }
        }
    }
}

struct FromNewView: View {
    
    @ObservedObject var groceryItems: GroceryItems
    @ObservedObject var savedCategories: Categories
    
    // Variables to build new GroceryItem object from
    @State private var selectedName: String = ""
    @State var selectedCategory: String = "None"
    @State private var selectedBestby: Date = Date()
    
    
    // Deal with dismissing this view and going back to home page
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                // Input item name
                TextField(
                    "Item Name",
                    text: $selectedName
                )
                
                // Select category
                // Passes in selectedCategory which is then updated in CategoryDetail and returned
                // Uses CategoryRow to display the row
                NavigationLink(destination: CategoryDetail(savedCategories: savedCategories, selectedCategory: $selectedCategory)) {
                    CategoryRow(categoryName: selectedCategory)
                }
                
                // Pick a best by date
                DatePicker("Best By", selection: $selectedBestby, displayedComponents: [.date])
                
                // Button to create the item and add to GroceryItems array
                Button(
                    "Add Item",
                    action: {
                        groceryItems.items.append(GroceryItem(name: self.selectedName, category: self.selectedCategory, bestby: self.selectedBestby))
                        dismiss()
                    }
                )
            }
            .navigationTitle("Add an Item")
        }
    }
}

#Preview {
    AddItem(groceryItems: GroceryItems(items: [GroceryItem(name: "Apple", category: "Produce", bestby: createDate(year: 2026, month: 1, day: 16))]), savedItems: SavedItems(items: [SavedItem(name: "Salmon", category: "Seafood", lifespan: 5)]), savedCategories: Categories(startingCategories: ["None", "Produce", "Dairy"]))
}
