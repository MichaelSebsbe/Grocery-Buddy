//
//  FavoriteRecipes.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 2023-09-24.
//

import Foundation

class FavoriteRecipes: ObservableObject {
    @Published var recipes = [Recipe]()
}
