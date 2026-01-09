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
    
    // Create the groceryItems object to keep track of groceries in use
    // Created and owned by ContentView but used elsewhere, so @StateObject
    @StateObject var groceryItems: GroceryItems = GroceryItems()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 2.0) {
                // Display list of all groceries currently stored
                // When cell clicked on, go into edit screen
                // When plus button clicked on, go into add screen
                List(groceryItems.items) { groceryItem in
                    NavigationLink(destination: EditItem(groceryItem: groceryItem)) {
                        ItemRow(groceryItem: groceryItem)
                    }
                }
                .navigationTitle(Text("Your Fridge/Pantry"))
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            AddItem(groceryItems: groceryItems)
                        } label: {
                            Image(systemName: "plus.app")
                                .font(.title2)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
