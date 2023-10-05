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
                    if let recipe = recipes.hits[index]?.recipe {
                        NavigationLink(destination: RecipeDetailView(recipe: recipe).navigationBarBackButtonHidden()){
                            RecipeCardFront(recipe: recipe)
                            
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            } else{
                Text("search from our 10,000 recipes!")
            }
    }
}

