//
//  Grocery_BuddyApp.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 12/21/22.
//

import SwiftUI

@main
struct Grocery_BuddyApp: App {
    init() {
        self.highlightSearch = true
    }
    
    let persistenceController = PersistenceController.shared
    let selectedIngredients = SelectedIngredients()
    let favoriteRecipes = FavoriteRecipes()
    
    @Environment(\.scenePhase) var scenePhase // detects change when app moves to environment
    
    @State private var tabSelection = 1
    @FocusState private var highlightSearch : Bool
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $tabSelection){
                RecipiesContentView(hightlightSearch: _highlightSearch)
                    .tabItem {
                        Label("Recipies", systemImage: "fork.knife.circle.fill")
                    }
                    .tag(1)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    
                //GroceryListView()
                GroceryItemsView(tabSelection: $tabSelection)
                    .tabItem {
                        Label("Shopping List", systemImage: "list.bullet.clipboard.fill")
                    }
                    .tag(2)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    
                YourRecipesView()
                    .tabItem {
                        Label("Your Recipes", systemImage: "heart.circle.fill")
                    }
                    .tag(3)
                
            }
            .environmentObject(selectedIngredients)
            .environmentObject(favoriteRecipes)
            .onChange(of: tabSelection){ newValue in
                highlightSearch = true
            }
        }
        .onChange(of: scenePhase) { newValue in
            persistenceController.save() //saves whenever app goes to background and fo
        }
    }
    
}
