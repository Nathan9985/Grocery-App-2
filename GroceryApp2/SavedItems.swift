//
//  SavedItems.swift
//  GroceryApp2
//
//  Created by Nathaniel Ruiz on 1/9/26.
//

/*
 * For saved items, a click should immediately add the item to the pantry,
 * Should need to click an edit button to actually enter edit mode
 */

import SwiftUI

struct SavedItemsView: View {
    
    // Bring in the groceryItems object to keep track of groceries user has saved
    @ObservedObject var savedItems: SavedItems
    @ObservedObject var groceryItems: GroceryItems
    @State private var selectedItemID: UUID?
    
    // States for filtering and sorting
    @State private var selectedCategory: Category = .None
    @State private var sortByLifespan = true
    
    // Deal with dismissing this view and going back to home page
    @Environment(\.dismiss) private var dismiss
    
    // Array to actually filter and sort groceryItems
    // Maintain one source of truth in groceryItems, maintain display properties in
    // displayedItems
    var displayedItems: [SavedItem] {
        savedItems.items
            .filter { item in
                // If selectedCategory is None, let all items pass, otherwise check category for match
                selectedCategory == .None || item.category == selectedCategory
            }
            .sorted { lhs, rhs in
                sortByLifespan ? lhs.lifespan < rhs.lifespan : lhs.name < rhs.name
            }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 2.0) {
                // Display list of all groceries currently saved
                List(selection: $selectedItemID) {
                    ForEach(displayedItems) { item in
                        SavedItemRow(savedItem: item)
                            .tag(item.id)
                    }
                    .onDelete(perform: deleteItem)
                }
                .navigationTitle(Text("Add a Saved Item"))
                // When item selected, add it to GroceryItems list
                .onChange(of: selectedItemID) {
                    let selectedItem = savedItems.items.first(where: {
                        $0.id == selectedItemID
                    })
                    let seconds = Double(selectedItem!.lifespan * 24 * 60 * 60)
                    let bestby = Date.now.addingTimeInterval(seconds)
                    groceryItems.items.append(GroceryItem(name: selectedItem!.name, category: selectedItem!.category, bestby: bestby))
                    dismiss()
                }
                .toolbar {
                    // Add item button
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            AddSavedItem(savedItems: savedItems)
                        } label: {
                            Image(systemName: "plus.app")
                                .font(.title2)
                        }
                    }
                    
                    // Sort by button
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            sortByLifespan.toggle()
                        } label: {
                            sortByLifespan ? Text("Lifespan") : Text("Name")
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
    }
    
    // Delete a groceryItem from savedItems underlying array
    func deleteItem(at offsets: IndexSet) {
        // Since onDelete could send in multiple indeces, go through each and delete from
        // actual array (groceryItems), not display array (displayedItems)
        for index in offsets {
            let displayID = displayedItems[index].id
            let itemIndex = savedItems.items.firstIndex(where: { $0.id == displayID })
            savedItems.items.remove(at: itemIndex!)
        }
    }
}

#Preview {
    SavedItemsView(savedItems: SavedItems(items: [SavedItem(name: "Salmon", category: .Meat, lifespan: 5)]), groceryItems: GroceryItems(items: [GroceryItem(name: "Apple", category: Category.Produce, bestby: createDate(year: 2026, month: 1, day: 16))]))
}
