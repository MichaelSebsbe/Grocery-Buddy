//
//  Grocery_BuddyApp.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 12/21/22.
//

import SwiftUI

@main
struct Grocery_BuddyApp: App {
    let persistenceController = PersistenceController.shared
    let selectedIngredients = SelectedIngredients()
    
    @Environment(\.scenePhase) var scenePhase // detects change when app moves to environment
    
    var body: some Scene {
        WindowGroup {
            TabView {
                RecipiesContentView()
                    .tabItem {
                        Label("Recipies", systemImage: "fork.knife.circle.fill")
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    
                //GroceryListView()
                GroceryItemsView()
                    .tabItem {
                        Label("Shopping List", systemImage: "list.bullet.clipboard.fill")
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
                
                
            }
            .environmentObject(selectedIngredients)
            
        }
        .onChange(of: scenePhase) { newValue in
            persistenceController.save() //saves whenever app goes to background and fo
        }
    }
    
}
