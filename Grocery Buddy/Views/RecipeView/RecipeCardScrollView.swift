//
//  Cards.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 12/30/22.
//

import SwiftUI

struct RecipieCardsScrollView: View {
    var recipes: RecipeResponse?
    
    var body: some View {
            if let recipes = recipes{
                
                let recipesCount = recipes.hits.count
                ForEach(0..<recipesCount, id: \.self) { index in
                    if let recipe = recipes.hits[index]?.recipe,
                       let imageURL = recipe.images["REGULAR"]!.url,
                       let foodName = recipe.label,
                       let recipeURL = recipe.url {
                        
                        let ingredients = recipe.ingredients
                        
                        NavigationLink(destination: RecipeDetailView(title: foodName, imageURL: imageURL, ingredients: ingredients, recipeURL: recipeURL).navigationBarBackButtonHidden()){
                            RecipeCardFront(recipe: recipe)
                            
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            } else{
                Text("search from our 10,000 recipes!")
            }
    }
}

