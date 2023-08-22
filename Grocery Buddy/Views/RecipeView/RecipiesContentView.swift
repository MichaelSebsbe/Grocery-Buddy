//
//  RecipiesContentView.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 12/22/22.
//

import SwiftUI

struct RecipiesContentView: View {
    @State var searchTerm = ""
    @State var recipies: RecipeResponse?
    @State var scrollToTop = false
    @State var featuredKeys = ["Burger", "Sushi", "Cupcake", "Lasagna", "Pizza"]
    
    var featuredRecipe : Recipe?{
        var recipe : Recipe? =  nil
        let semaphore = DispatchSemaphore(value: 0)
        
        let key = featuredKeys.remove(at: Int.random(in: 0..<featuredKeys.count))
        
        RequestManager.getRecpies(for: key) { recipies in
            if let recipies = recipies{
                recipe = recipies.hits[Int.random(in: 0...5)]?.recipe //grab random Recipe
            }
            semaphore.signal()
        }
        semaphore.wait()
        return recipe
        
    }
    
    var body: some View {
        NavigationView{
            VStack{
                SearchBar(searchText: $searchTerm, recipies: $recipies, hasNewResults: $scrollToTop)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                
                if scrollToTop == true {
                    ScrollViewReader { proxy in
                        ScrollView(.vertical, showsIndicators: true) {
                            RecipieCardsScrollView(recipes: recipies)
                            
                        }.onChange(of: scrollToTop) { _ in
                            scrollToTop = false
                            withAnimation {
                                proxy.scrollTo(0)
                                
                            }
                            
                        }
                    }
                } else {
                    Label {
                        Text("Today's Featured Recipies")
                    } icon: {
                        Image(systemName: "star.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .yellow)
                    }
                    .font(.headline)
                        
                    ScrollView(.vertical, showsIndicators: true) {
                        FeaturedRecipeCard(recipe: featuredRecipe!)
                        FeaturedRecipeCard(recipe: featuredRecipe!)
                        FeaturedRecipeCard(recipe: featuredRecipe!)
                        FeaturedRecipeCard(recipe: featuredRecipe!)
                        FeaturedRecipeCard(recipe: featuredRecipe!)
                    }
                }
            }
        }
    }
}

struct RecipiesContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipiesContentView()
            .previewDevice("iPhone 11")
    }
}


// MARK: - SearchBar

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var recipies: RecipeResponse?
    @Binding var hasNewResults: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(red: 0.02, green: 0.87, blue: 0.62))
            
            TextField("Search", text: $searchText)
                .foregroundColor(Color(red: 0.02, green: 0.87, blue: 0.62))
                .font(.title2)
                .onSubmit {
                   // make query Request
                    RequestManager.getRecpies(for: searchText) { recipies in
                        
                        if let recipies = recipies{
                            self.recipies = recipies
                            self.hasNewResults = true
                        }else{
                            print("RequestManager.getRecpies: Error fetching requests")
                        }
                    }
                }
            
            //cancel Button
            Button(action: {
                searchText = ""
       
            }) {
                Image(systemName: "xmark.circle.fill")
                    .opacity(searchText == "" ? 0 : 1)
                    .foregroundColor(Color(red: 0.9, green: 0.39, blue: 0.4))
            }
        }
        .padding(10)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}



