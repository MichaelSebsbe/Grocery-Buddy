//
//  GroceryItems.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 8/21/23.
//

import SwiftUI

struct GroceryItemsView: View {
    @EnvironmentObject var ingredientsManagedObject: SelectedIngredients
    
    var body: some View {
        ScrollView{
            ForEach(Array(ingredientsManagedObject.ingredients.keys.sorted()), id: \.self){ category in
                GroceryCategoryView(category: category)
                
                let ingredients = ingredientsManagedObject.ingredients[category]!
                let sortedIngredients = ingredients.values.sorted{$0.food! < $1.food!}
                
                ForEach(sortedIngredients, id:  \.self.foodId) { ingredient in
                    GroceryView(ingredient: ingredient)
                }
            }
        }
    }
}

struct GroceryItems_Previews: PreviewProvider {
    static var previews: some View {
        GroceryItemsView()
    }
}

struct GroceryCategoryView: View{
    var category: String
    var body: some View{
        HStack{
            Text(category)
                .font(.footnote)
            Spacer()
        }
        .padding(.leading)
    }
}


struct GroceryView: View {
    @State var isFound = false
    let ingredient: Ingredient
    var imageURL: String {
        ingredient.image ?? "Default Image url"
    }
    
    var name: String {
        ingredient.food?.capitalized ?? "Missing Value"
    }
    
    var amount: String{
        if let quantity = ingredient.quantity {
            //return "\(Int(quantity))"
            let isInteger = floor(quantity) == quantity
            
            //if whole number, drop decimals
            if(isInteger) {
                return "\(Int(floor(quantity)))"
            }
            
            //if measure should have 1 decimal
            if ((round(quantity * 10) / 10.0) == (round(quantity * 100) / 100.0)){
                return String(format: "%.1f", quantity)
            }
            
            //other wise return with 2 decimals
            return String(format: "%.2f", quantity)
        }
        return "N/A"
    }
    
    var measure: String {
        if let measure = ingredient.measure {
            if( measure == "<unit>" ){
                return ""
            }
            return measure
        }
        return ""
    }
    
    var body: some View{
        ZStack {
            Rectangle()
                .foregroundColor(.yellow)
                .frame(height: 75)
                .cornerRadius(10)
            
            HStack{
                AsyncImage(url: URL(string: imageURL)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 5)
                )
                
                Text(name)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("|")
                    .foregroundColor(.white)
                if(amount != "0"){
                    Text("\(amount) \(measure)")
                }
            }
            .padding(10)
            
            if(isFound){ //draw a line across
                Rectangle()
                    .frame(height: 1)
                    .padding(EdgeInsets(top: 0, leading: 80, bottom: 0, trailing: 10))
            }
        }
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
        .if(isFound){
            $0.opacity(0.2)
        }
        .onTapGesture {
            withAnimation(.easeIn(duration: 0.5)){
                isFound.toggle()
            }
        }
    }
}
