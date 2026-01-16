//
//  ItemData.swift
//  GroceryApp2
//
//  Created by Nathaniel Ruiz on 1/8/26.
//

import Foundation
import Combine
import SwiftUI

/*
 * Represent a single GroceryItem within the user's fridge/pantry
 */
class GroceryItem: Identifiable, ObservableObject {
    
    let id = UUID()
    
    @Published var name: String
    @Published var category: String
    @Published var bestby: Date
    
    init(name: String, category: String, bestby: Date) {
        self.name = name
        self.category = category
        self.bestby = bestby
    }
}

/*
 * Represent possible categories user can choose from
 * User can add to and remove from this list
 */
class Categories: ObservableObject {
    
    @Published private var categories: [String]
    
    // Initialize an empty categories array
    init() {
        categories = []
    }
    
    // Initialized a pre-filled categories array
    init(startingCategories: [String]) {
        categories = startingCategories
    }
    
    // Add the category if it does not exist already
    func addCategory(categoryName: String) {
        if (categories.contains(categoryName)) {
            print("Category \(categoryName) already exists")
        } else {
            categories.append(categoryName)
        }
    }
    
    // Remove a given category by name
    func removeByName(categoryName: String) {
        categories.removeAll { $0 == categoryName }
    }
    
    // Remove a given category by index
    func removeByIndex(categoryIndex: Int) {
        categories.remove(at: categoryIndex)
    }
    
    // Return the underlying categories array for more separation
    // Can also make the array private to make extra private
    func getCategories() -> [String] {
        return categories
    }
    
    // Return the category String in a specific index
    func getByIndex(categoryIndex: Int) -> String {
        return categories[categoryIndex]
    }
}

/*
 * Adapted from https://stackoverflow.com/questions/71626331/create-date-by-components-in-swift
 */
func createDate(year: Int, month: Int, day: Int)->Date {
   let calendar = Calendar.current

    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = day

   let date = calendar.date(from: dateComponents) ?? .now
   return date
}

/*
 * Underlying data structure for GroceryItem objects
 */
class GroceryItems: ObservableObject {
    // Alert SwiftUI when underlying items array changes
    @Published var items: [GroceryItem]
    
    // Empty initializer, create empty array of GroceryItems
    init() {
        self.items = []
    }
    
    // Create GroceryItems object given an array of GroceryItems (used for display testing)
    init(items: [GroceryItem]) {
        self.items = items
    }
    
    // Used for making sure List in ContentView refreshes when an item is updated
    // since otherwise, item updates aren't sent
    func itemDidChange() {
        objectWillChange.send()
    }
}
