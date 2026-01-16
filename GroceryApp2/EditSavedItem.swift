//
//  EditSavedItem.swift
//  GroceryApp2
//
//  Created by Nathaniel Ruiz on 1/9/26.
//

import SwiftUI

struct EditSavedItem: View {
    // SavedItem object is received from SavedItems, thus @ObservedObject
    @ObservedObject var savedItem: SavedItem
    @ObservedObject var savedCategories: Categories
    
    @State var updatedName: String = ""
    @State var updatedCategory: String = "None"
    @State var UpdatedLifespan: Int = 0
    
    private let lifespanFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.allowsFloats = false
        formatter.minimum = 0
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .center) {
            // Gather the Name, Category, and Lifespan,
            // then add it to the underlying object of SavedItem
            NavigationView {
                Form {
                    TextField(
                        "Item Name",
                        text: $updatedName
                    )
                    
                    // Select category
                    NavigationLink(destination: CategoryDetail(savedCategories: savedCategories, selectedCategory: $updatedCategory)) {
                        CategoryRow(categoryName: updatedCategory)
                    }
                    
                    TextField(
                        "Lifespan",
                        value: $UpdatedLifespan,
                        formatter: lifespanFormatter
                    )
                    
                    Button(
                        "Update Item",
                        action: {
                            self.savedItem.name = updatedName
                            self.savedItem.category = updatedCategory
                            self.savedItem.lifespan = UpdatedLifespan
                        }
                    )
                }
                .onAppear() {
                    // Prepopulate @State variables with current value in list
                    updatedName = savedItem.name
                    updatedCategory = savedItem.category
                    UpdatedLifespan = savedItem.lifespan
                }
            }
        }
    }
}

#Preview {
    EditSavedItem(savedItem: SavedItem(name: "Apple", category: "Produce", lifespan: 7), savedCategories: Categories(startingCategories: ["None", "Produce", "Canned", "Seafood"]))
}
