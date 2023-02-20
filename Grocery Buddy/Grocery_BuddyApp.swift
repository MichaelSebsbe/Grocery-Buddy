//
//  Grocery_BuddyApp.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 12/21/22.
//

import SwiftUI

@main
struct Grocery_BuddyApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabView {
                RecipiesContentView()
                    .tabItem {
                        Label("Recipies", systemImage: "fork.knife.circle.fill")
                            
                    }
                GroceryListView()
                    .tabItem {
                        Label("Cart", systemImage: "cart.fill")
                    }
                   
            }
        }
    }
}
