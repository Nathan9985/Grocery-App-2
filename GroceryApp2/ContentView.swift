//
//  ContentView.swift
//  GroceryApp2
//
//  Created by Nathaniel Ruiz on 1/7/26.
//

/*
 * TODO: Be able to filter by where in the home it would be by tabs or filter button
 *       Sort by days remaining
         Tinted cells by days remaining
 */

import SwiftUI
import CoreData

struct ContentView: View {
    
    // Create the groceryItems and savedItems objects to keep track of groceries in use and saved
    // Created and owned by ContentView but used elsewhere, so @StateObject
    @StateObject var groceryItems: GroceryItems = GroceryItems()
    @StateObject var savedItems: SavedItems = SavedItems()
    
    // States for filtering and sorting
    @State private var selectedCategory: Category = .None
    @State private var sortByBestby = true
    
    // Array to actually filter and sort groceryItems
    // Maintain one source of truth in groceryItems, maintain display properties in
    // displayedItems
    var displayedItems: [GroceryItem] {
        groceryItems.items
            .filter { item in
                // If selectedCategory is None, let all items pass, otherwise check category for match
                selectedCategory == .None || item.category == selectedCategory
            }
            .sorted { lhs, rhs in
                sortByBestby ? lhs.bestby < rhs.bestby : lhs.name < rhs.name
            }
    }
    
    var body: some View {
        NavigationView {
            // Display list of all groceries currently stored
            // When cell clicked on, go into edit screen
            // When plus button clicked on, go into add screen
            List() {
                ForEach(displayedItems) { item in
                    NavigationLink(destination: EditItem(groceryItem: item, groceryItems: groceryItems)) {
                        ItemRow(groceryItem: item)
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .navigationTitle(Text("Your Fridge/Pantry"))
            .toolbar {
                // Add item button
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddItem(groceryItems: groceryItems, savedItems: savedItems)
                    } label: {
                        Image(systemName: "plus.app")
                            .font(.title2)
                    }
                }
                
                // Sort by button
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        sortByBestby.toggle()
                    } label: {
                        sortByBestby ? Text("Best by") : Text("Name")
                    }
                }
                
                // Filter button
                ToolbarItem(placement: .topBarLeading) {
                    Picker("Fitler", selection: $selectedCategory) {
                        ForEach(Category.allCases, id: \.self) { category in
                            if (category == .None) {
                                Text("All")
                            } else {
                                Text(category.rawValue)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Delete a groceryItem from groceryItems underlying array
    // Because they are selecting from the filtered and sorted list,
    // get the unique ID of the item and use that to delete from underlying array
    // since the indeces no longer align
    func deleteItem(at offsets: IndexSet) {
        // Since onDelete could send in multiple indeces, go through each and delete from
        // actual array (groceryItems), not display array (displayedItems)
        for index in offsets {
            let displayID = displayedItems[index].id
            let itemIndex = groceryItems.items.firstIndex(where: { $0.id == displayID })
            groceryItems.items.remove(at: itemIndex!)
        }
    }
}

#Preview {
    ContentView()
}
