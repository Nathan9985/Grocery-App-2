//
//  SavedItemData.swift
//  GroceryApp2
//
//  Created by Nathaniel Ruiz on 1/9/26.
//

import Foundation
import Combine
import SwiftUI

/*
 * Represent a single SavedItem within the user's app
 */
class SavedItem: Identifiable, ObservableObject {
    
    let id = UUID()
    
    @Published var name: String
    @Published var category: String
    @Published var lifespan: Int
    
    init(name: String, category: String, lifespan: Int) {
        self.name = name
        self.category = category
        self.lifespan = lifespan
    }
}

/*
 * Underlying data structure for SavedItem objects
 */
class SavedItems: ObservableObject {
    // Alert SwiftUI when underlying items array changes
    @Published var items: [SavedItem]
    
    // Empty initializer, create empty array of SavedItems
    init() {
        self.items = []
    }
    
    // Create SavedItems object given an array of SavedItems (used for display testing)
    init(items: [SavedItem]) {
        self.items = items
    }
}
