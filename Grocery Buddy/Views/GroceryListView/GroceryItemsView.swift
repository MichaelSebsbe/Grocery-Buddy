//
//  GroceryItems.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 8/21/23.
//

import SwiftUI

struct GroceryItemsView: View {
    @EnvironmentObject var ingredientsManagedObject: SelectedIngredients
    @Binding var tabSelection : Int 
    
    @State private var foundIngredients = [String: Ingredient]()
    
    var body: some View {
        VStack(alignment: .center){
            ScreenTitle(title: "Your Shopping List", imageSystemName: "cart.circle.fill", screenColor: .green)
            
            if ingredientsManagedObject.ingredients.count == 0 {
                Spacer()
                LottieView(filename: "Loading.json")
                    .frame(width:150,height: 150)
                    .opacity(0.8)
                Text("Add groceries by searching recipes ⬅️ groceries.")
                    .font(.caption)
                    .padding()
                
                Button("Search Recipe") {
                            //button pressed
                    self.tabSelection = 1
                }
                .tint(AppColors.mint)
                .foregroundColor(.black)
                .cornerRadius(100)
                
                
                Spacer()
                
            } else {
                if foundIngredients.count > 0 {
                    //clear button
                    HStack{
                        Button {
                            for foundIngredient in foundIngredients{
                                withAnimation(.easeOut) {
                                    ingredientsManagedObject.remove(foundIngredient.value)
                                    foundIngredients.removeValue(forKey: foundIngredient.key)
                                }
                            }
                            
                        } label: {
                            HStack{
                                Image(systemName: "checkmark.seal.fill")
                                    .frame(width: 20, height: 20)
                                Text("Clear Found")
                            }
                        }
                        .tint(AppColors.red)
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                ScrollView{
                    ForEach(Array(ingredientsManagedObject.ingredients.keys.sorted()), id: \.self){ category in
                        HStack{
                            Spacer()
                            GroceryCategoryView(category: category)
                        }
                        .padding(.horizontal)
                        
                        let ingredients = ingredientsManagedObject.ingredients[category]!
                        let sortedIngredients = ingredients.values.sorted{$0.food! < $1.food!}
                        
                        ForEach(sortedIngredients, id:  \.self.foodId) { ingredient in
                            GroceryView(ingredient: ingredient){ isFound in
                                if let id = ingredient.foodId{
                                    if isFound{
                                        foundIngredients[id] = ingredient
                                    } else {
                                        foundIngredients.removeValue(forKey: id)
                                    }
                                }
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                //add all to cart
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

struct GroceryCategoryView: View{
    var category: String
    var body: some View{
        HStack{
            Text(category)
                .font(.caption2)
                .bold()
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 4, leading: 7, bottom: 4, trailing: 7))
                .background(AppColors.purple)
                .cornerRadius(200)
        }
    }
}

struct GroceryCategoryViewPreview: PreviewProvider {
    
    typealias Previews = GroceryCategoryView
    
    static var previews: GroceryCategoryView {
        GroceryCategoryView(category:"Condiments")
    }
}


struct GroceryView: View {
    @State var isFound = false
    let ingredient: Ingredient
    var callback : (Bool) -> Void
    
    var body: some View{
        HStack{
            if isFound{
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundColor(.green)
                    .frame(width: 30, height: 30)
            }
            
            ChecklistView(isFound: $isFound, ingredient: ingredient)
                .onTapGesture {
                    withAnimation(.snappy){
                        isFound.toggle()
                        callback(isFound)
                    }
                }
                .if(isFound){
                    $0.opacity(0.9)
                }
        }
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
    }
}


struct ChecklistView: View {
    @Binding var isFound: Bool
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
                .frame(height: 75)
                .cornerRadius(10)
                .shadow(color: Color(red: 0.2, green: 0.28, blue: 0.30, opacity: 0.3), radius: 2, x: 1, y: 1)
                .if(isFound){
                    $0.foregroundColor(.green)
                }
                .if(!isFound){
                    $0.foregroundColor(.yellow)
                }
            
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
            
//            if(isFound){ //draw a line across
//                Rectangle()
//                    .frame(height: 1)
//                    .padding(EdgeInsets(top: 0, leading: 80, bottom: 0, trailing: 10))
//            }
        }
    }
}
