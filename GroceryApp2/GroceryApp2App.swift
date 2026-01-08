//
//  GroceryApp2App.swift
//  GroceryApp2
//
//  Created by Nathaniel Ruiz on 1/7/26.
//

import SwiftUI
import CoreData

@main
struct GroceryApp2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
