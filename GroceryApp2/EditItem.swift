//
//  EditItem.swift
//  GroceryApp2
//
//  Created by Nathaniel Ruiz on 1/8/26.
//

import Foundation
import SwiftUI

struct EditItem: View {
    
    // GroceryItem object is received from ContentView, thus @ObservedObject
    @ObservedObject var groceryItem: GroceryItem
    @ObservedObject var groceryItems: GroceryItems
    
    @State var updatedName: String = ""
    @State var updatedCategory: Category = .None
    @State var UpdatedBestby: Date = Date()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .center) {
            // Gather the Name, Category, and Best By date of new item,
            // then add it to the underlying object of GroceryItems
            Form {
                TextField(
                    "Item Name",
                    text: $updatedName
                )
                
                Picker("Category", selection: $updatedCategory) {
                    ForEach(Category.allCases, id: \.self) { category in
                        Text(category.rawValue)
                    }
                }
                
                DatePicker("Best By", selection: $UpdatedBestby, displayedComponents: [.date])
                
                Button(
                    "Update Item",
                    action: {
                        self.groceryItem.name = updatedName
                        self.groceryItem.category = updatedCategory
                        self.groceryItem.bestby = UpdatedBestby
                        
                        groceryItems.itemDidChange()
                        dismiss()
                    }
                )
            }
            .onAppear() {
                // Prepopulate @State variables with current value in list
                // Do onAppear instead of an init so keep the @ObservedObject and
                // @State variables in sync
                updatedName = groceryItem.name
                updatedCategory = groceryItem.category
                UpdatedBestby = groceryItem.bestby
            }
        }
    }
}

#Preview {
    EditItem(groceryItem: GroceryItem(name: "Apple", category: Category.Produce, bestby: createDate(year: 2026, month: 1, day: 16)), groceryItems: GroceryItems(items: []))
}
