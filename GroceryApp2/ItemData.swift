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
    @Published var category: Category
    @Published var bestby: Date
    
    init(name: String, category: Category, bestby: Date) {
        self.name = name
        self.category = category
        self.bestby = bestby
    }
}

/*
 * Represent all possible categories user can choose from.
 *
 * Todo: Allow user to create their own
 */
enum Category: String, CaseIterable, Identifiable {
    case None = "None"
    case Produce = "Produce"
    case Canned = "Canned"
    case Meat = "Meat"
    case Dairy = "Dairy"
    
    var id: String { self.rawValue }
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
}
