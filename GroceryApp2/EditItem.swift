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
    
    var body: some View {
        VStack(alignment: .center) {
            Text(groceryItem.name)
            
            Button(
                "Change Text",
                action: {
                    groceryItem.name = "\(groceryItem.name) But Better"
                }
            )
        }
    }
}

#Preview {
    EditItem(groceryItem: GroceryItem(name: "Apple", category: Category.Produce, bestby: createDate(year: 2026, month: 1, day: 16)))
}
