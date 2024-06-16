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
    var count = 0
    
    let defaultImageURL = "bad/code"
    
    var body: some View {
        NavigationView {
            VStack{
                ScreenTitle(title: "Your Recipes!", imageSystemName: "heart.circle.fill", screenColor: .red)
                ScrollView{
                    
                    ForEach(Array(favRecipies.recipes), id: \.self.uri){ recipe in
                        //FeaturedRecipeCard(recipe: recipe, screenTheme: .red)
                        if let urlString = recipe.image,
                           let link = recipe.url{
                            let url = URL(string: urlString)
                            
                            let title = recipe.label ?? " YUMMy YuUUMM"
                            let cookTime = recipe.totalTime ?? 0
                            
                            
                            RecipeLinkView(imageUrl: url, title: title, link: link, time: cookTime)
                                .frame(maxWidth: .greatestFiniteMagnitude)
                                .padding(.horizontal)
                               
                        }
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

