//
//  ItemRow.swift
//  GroceryApp2
//
//  Created by Nathaniel Ruiz on 1/8/26.
//

import SwiftUI

// How to display a single row within ContentView's List
struct ItemRow: View {
    
    @ObservedObject var groceryItem: GroceryItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2.0) {
            HStack {
                Text(groceryItem.name)
                    .font(.title)
                Spacer()
                let dateString = groceryItem.bestby.formatted(date: .abbreviated, time: .omitted)
                Text(dateString)
                    .font(.subheadline)
            }
            HStack {
                Text(groceryItem.category.rawValue)
                    .font(.subheadline)
                Spacer()
                // Get days from today to bestby date ignore time of day
                let timeDifference = groceryItem.bestby.timeIntervalSinceReferenceDate - Date.now.timeIntervalSinceReferenceDate
                let daysDifference = ((timeDifference / 60) / 60) / 24
                let daysRemaining = Int(daysDifference.rounded(.up))
                Text("Days Remaining: \(daysRemaining)")
                    .font(.title3)
            }
        }
    }
}

#Preview {
    ItemRow(groceryItem: GroceryItem(name: "Apple", category: Category.Produce, bestby: createDate(year: 2026, month: 1, day: 12)))
}
