//
//  RecipiesContentView.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 12/22/22.
//

import SwiftUI

struct RecipiesContentView: View {
    @State var items: [Int] = [2,3,5,7,9,65]
    @State var searchTerm = ""
    @State var recipies: RecipeResponse?
    
    var body: some View {
        ZStack {
            Color(red: 0.2, green: 0.79, blue: 0.9, opacity: 0.6)
                .ignoresSafeArea()
            
            VStack{
                if let recipies = recipies{
                    Text(recipies.hits?[0].recipe?.label ?? "nothing")
                }
                SearchBar(searchText: $searchTerm, recipies: $recipies)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                
                RecipieCards(recipes: $recipies)
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
                        }else{
                            print("RequestManager.getRecpies: Error fetching requests")
                        }
                    }
                }

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



