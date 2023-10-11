//
//  YourRecipesView.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 2023-09-06.
//
//

import SwiftUI

struct YourRecipesView: View {
    @EnvironmentObject var favRecipies: FavoriteRecipes // will container
    
    var body: some View {
        NavigationView {
            VStack{
                ScreenTitle(title: "Your Recipes!", imageSystemName: "heart.circle.fill", screenColor: .red)
                ScrollView{
                    ForEach(Array(favRecipies.recipes), id: \.self.uri) { recipe in
                        FeaturedRecipeCard(recipe: recipe, screenTheme: .red)
                    }
                }
            }
        }
    }
}

struct YourRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        YourRecipesView()
    }
}

