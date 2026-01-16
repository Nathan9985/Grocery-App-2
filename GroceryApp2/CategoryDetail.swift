//
//  CategoryDetail.swift
//  GroceryApp2
//
//  Created by Nathaniel Ruiz on 1/12/26.
//

import SwiftUI

// View for selecting a category
struct CategoryDetail: View {
    
    @ObservedObject var savedCategories: Categories
    
    // Variable to pass back to the previous screen to let view know what
    // category was selected
    @Binding var selectedCategory: String
    
    // Variable used to locally track which category is selected
    // Used to allow selectedCategory to be a String while localSelectedCategory
    // is a String? since List(selection:) requires an optional
    @State var localSelectedCategory: String?
    
    // Used to allow dismiss() call to return to previous screen
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            // List the categories currently in categoryOptions list
            // Can either add categories using button or select a category
            // which is then passed back to the previous View
            List(selection: $localSelectedCategory) {
                ForEach(savedCategories.getCategories(), id: \.self) { category in
                    Text(category)
                        .tag(category)
                }
                .onDelete(perform: deleteItem)
            }
            .navigationTitle(Text("Select Category"))
            .onChange(of: localSelectedCategory) {
                selectedCategory = localSelectedCategory!
                dismiss()
            }
            .toolbar {
                // Add category button
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddCategory(savedCategories: savedCategories)
                    } label: {
                        Image(systemName: "plus.app")
                            .font(.title2)
                    }
                }
            }
        }
    }
    
    // Deal with deleting a category item when using swipe-to-delete
    // Robust to deal with multiselect delete functionality
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            if (savedCategories.getByIndex(categoryIndex: index) != "None") {
                savedCategories.removeByIndex(categoryIndex: index)
            }
        }
    }
}

// View for adding a category
struct AddCategory: View {
    
    @ObservedObject var savedCategories: Categories
    @State var newCategoryName: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationView {
            Form {
                // Field to enter new category name
                TextField(
                    "Category Name",
                    text: $newCategoryName
                )
                
                // Button to add new category to list
                Button(
                    "Add Category",
                    action: {
                        savedCategories.addCategory(categoryName: newCategoryName)
                        dismiss()
                    }
                )
            }
        }
    }
}

#Preview {
    CategoryDetail(savedCategories: Categories(startingCategories: ["None", "Produce", "Canned", "Seafood"]), selectedCategory: .constant("None"))
}
