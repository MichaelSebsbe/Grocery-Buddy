//
//  RecipeDetailView.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 2/8/23.
//

import SwiftUI
import WebKit

struct RecipeDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var selectedCount: Int = 0
    @State private var allSelected = false
    
    let title: String
    let imageURL: String
    let ingredients: [Ingredient]
    var sanitizedIngredients: [Ingredient]{
        var ingredientIDs = [String]()
        var sanitaizedIngredients = [Ingredient]()
        
        for ingredient in ingredients {
            if let id = ingredient.foodId{
                if(!ingredientIDs.contains(id)){
                    ingredientIDs.append(id)
                    sanitaizedIngredients.append(ingredient)
                }
            }
        }
        
        return sanitaizedIngredients
    }
    let recipeURL: String
    
    //let ingredients: [String]
    var body: some View {
        VStack{
            TopButtons(presentationMode: presentationMode, url: recipeURL)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            ZStack{
                Rectangle()
                    .foregroundColor(.yellow)
                    .cornerRadius(20)
    
                VStack() {
                    HStack (alignment: .center){
                        Text(title)
                            .font(.system(size:40))
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .minimumScaleFactor(0.4)
                        // .lineLimit(4)
                            .if {
                                title.count < 41 ? $0.lineLimit(3) : $0.lineLimit(4)
                            }
                            .multilineTextAlignment(.trailing)
                            .textCase(.uppercase)
                        Divider()
                            .frame(width: 4, height: 125)
                            .overlay(.white)
                        
                        AsyncImage(url: URL(string: imageURL)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 125,height: 125)
                        .cornerRadius(15)
                    }
                    
                    Divider()
                        .frame(height: 4)
                        .overlay(.black)
                        .offset(x: 0, y: -15)
                    
                    ScrollView(.vertical, showsIndicators: false){
                        ForEach(sanitizedIngredients, id: \.self.foodId){ ingredient in
                            IngredientView(allSelected: $allSelected, selectCount: $selectedCount, ingredient: ingredient)
                        }.padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 0))
                        
                    }.padding(.top, -23).padding(.bottom,-16) //for flush scroll view
                    
                }.padding()
                
                Spacer()
                
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            HStack{
                Button("Add All") {
                    //add all ingridents to grocery cart
                    withAnimation(.easeIn(duration: 0.5)){
                        allSelected = true
                        selectedCount = sanitizedIngredients.count
                    }
                    
                }
                
                Text("\(selectedCount) out of \(sanitizedIngredients.count)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .fontWeight(.semibold)
                Button("Add To Cart"){
                    self.presentationMode.wrappedValue.dismiss()
                }
                .tint(.yellow)
                .foregroundColor(.black)
                
            }.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            
        }
    }
}


struct RecipeDetailView_Previews: PreviewProvider {

    static var previews: some View {
        RecipeDetailView(title:"I just wanted to count the digits of th", imageURL:"https://3.bp.blogspot.com/-MPmB8FO8yjA/WUviA9tctaI/AAAAAAAALK8/LFjrerEl4yMiRvsnj-Wd0gggNYxA2dGOACLcBGAs/s1600/22Salu%2BBinagoongang-Lechon-Karekare.JPG", ingredients: [
            Ingredient(text: "Mayonnaise", quantity: 2.5, measure: "Cuperroni", food: "Mayonnaise with shshsd", weight: 3, foodCategory: "dsf", foodId: "22", image: "https://i2-prod.dailystar.co.uk/incoming/article23201324.ece/ALTERNATES/s615b/0_Bowl-of-mayonnaise-with-spoon-embedded-view-from-above.jpg"),
            Ingredient(text: "Mayonnaise", quantity: 2.5, measure: "Cups", food: "Mayonnaise", weight: 3, foodCategory: "dsf", foodId: "23", image: "https://i2-prod.dailystar.co.uk/incoming/article23201324.ece/ALTERNATES/s615b/0_Bowl-of-mayonnaise-with-spoon-embedded-view-from-above.jpg"),
            Ingredient(text: "Mayonnaise", quantity: 2.5, measure: "Cups", food: "Mayonnaise", weight: 3, foodCategory: "dsf", foodId: "24", image: "https://i2-prod.dailystar.co.uk/incoming/article23201324.ece/ALTERNATES/s615b/0_Bowl-of-mayonnaise-with-spoon-embedded-view-from-above.jpg"),
            Ingredient(text: "Mayonnaise", quantity: 2.5, measure: "Cuperroni", food: "Mayo", weight: 3, foodCategory: "dsf", foodId: "25", image: "https://i2-prod.dailystar.co.uk/incoming/article23201324.ece/ALTERNATES/s615b/0_Bowl-of-mayonnaise-with-spoon-embedded-view-from-above.jpg"),
            Ingredient(text: "Mayonnaise", quantity: 2.5, measure: "Cups", food: "Mayonnaise", weight: 3, foodCategory: "dsf", foodId: "26", image: "https://i2-prod.dailystar.co.uk/incoming/article23201324.ece/ALTERNATES/s615b/0_Bowl-of-mayonnaise-with-spoon-embedded-view-from-above.jpg"),
            Ingredient(text: "Mayonnaise", quantity: 2.5, measure: "Cups", food: "Mayonnaise", weight: 3, foodCategory: "dsf", foodId: "27", image: "https://i2-prod.dailystar.co.uk/incoming/article23201324.ece/ALTERNATES/s615b/0_Bowl-of-mayonnaise-with-spoon-embedded-view-from-above.jpg")
            
        ],
                         recipeURL: "https://google.com"
        ).previewDevice("iPhone 14")
        
    }
    
}

struct IngredientView: View {
    @EnvironmentObject var selectedIngredients: SelectedIngredients
    @State var isSelected: Bool = false
    @Binding var allSelected: Bool
    @Binding var selectCount: Int
    
    var ingredient: Ingredient
    var imageURL: String {
        ingredient.image ?? "default image url"
    }
    var label: String {
        ingredient.food ?? "???????"
    }
    var measurement: String {
        if let measure = ingredient.measure {
            if( measure == "<unit>" ){
                return ""
            }
            return measure
        }
        return ""
    }
    var quantity: String {
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
    
    var body: some View {
        HStack{
            // if (isSelected){
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 75,height: 75)
            .clipShape(Circle())
            .overlay(
                Circle().if{
                    if(isSelected || allSelected){
                        $0.stroke(Color.mint,lineWidth:5)
                    } else {
                        $0.stroke(Color.white, lineWidth: 5)
                    }
                }
                    
            )
            
            Text(label)
                .font(.system(size: 20))
                .textCase(.uppercase)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .minimumScaleFactor(0.4)
                .if(isSelected || allSelected){
                    $0.foregroundColor(.mint)
                }
            
            Spacer()
            
            if(quantity != "0"){
                Text("| \(quantity) \(measurement)")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                    .fontWeight(.bold)
                    .textCase(.uppercase)
                    .if(isSelected || allSelected){
                        $0.foregroundColor(.mint)
                    }
            }
        }.if{
            if(isSelected || allSelected){
                $0.background(LinearGradient(gradient: Gradient(colors: [.yellow, .white]), startPoint: .trailing, endPoint: .leading).cornerRadius(50))
                    
            } else {
                $0
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeIn(duration: 0.5)){
                isSelected.toggle()
                
                guard let foodId = ingredient.foodId
                else {
                    print("Error: Cannot add ingredient to cart (Missing FoodID)")
                    return
                }
            
                if(isSelected){
                    selectedIngredients.ingredients[foodId] = ingredient
                    selectCount += 1
                }else{
                    selectedIngredients.ingredients.removeValue(forKey: foodId)
                    selectCount -= 1
                }
            }
        }
    }

}

extension View{
    /// Closure given view if conditional.
    /// - Parameters:
    ///   - conditional: Boolean condition.
    ///   - content: Closure to run on view.
    @ViewBuilder func `if`<Content: View>(_ conditional: Bool = true, @ViewBuilder _ content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}



struct TopButtons: View {
    @Binding var presentationMode: PresentationMode
    @State private var showWebView = false
    let url: String
    var body: some View {
        HStack {
            Button {
                self.$presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.red)
            }
            //.frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Button {
                showWebView.toggle()
            } label: {
                
                HStack {
                    Image(systemName: "safari")
                        .font(.system(size: 30))
                    Text("Read Full Recipe")
                        .fontWeight(.heavy)
                        .lineLimit(1)
                }
                .foregroundColor(.mint)
            }
            .sheet(isPresented: $showWebView) {
                if let url = URL(string: url){
                    RecipeWebView(url: url)
                }
            }
        }
    }
}

