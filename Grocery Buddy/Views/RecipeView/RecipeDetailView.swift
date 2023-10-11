//
//  RecipeDetailView.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 2/8/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var selectedIngredientsEnvObj: SelectedIngredients
    @EnvironmentObject var favRecipes : FavoriteRecipes
    
    let recipe: Recipe
    
    var title: String {
        if let foodName = recipe.label{
            return foodName
        }
        return "Missing Name"
    }
    var  imageURL: String {
        if let imageURL = recipe.images["REGULAR"]!.url{
            return imageURL
        }
        return "DefualtImageURL"
    }
    
    var ingredients: [Ingredient]{
        recipe.ingredients
    }
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
    
    @State var selectedIngredients = [String: Ingredient]()
    
    var recipeURL: String {
        if let url = recipe.url {
            return url
        }
        return "Missing URL"
    }

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
                            IngredientView(selectedIngredients: $selectedIngredients, ingredient: ingredient)
                        }.padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 0))
                        
                    }.padding(.top, -23).padding(.bottom,-16) //for flush scroll view
                    
                }.padding()
                
                Spacer()
                
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            HStack{
                Button("Select All") {
                    //add all ingridents to grocery cart
                    withAnimation(.easeIn(duration: 0.5)){
                        for ingredient in sanitizedIngredients {
                            if let foodId = ingredient.foodId{
                                selectedIngredients[foodId] = ingredient
                            }
                        }
                    }
                    
                }
                
                Text("\(selectedIngredients.count) out of \(sanitizedIngredients.count)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .fontWeight(.semibold)
                Button("Save"){
                    //selectedIngredientsEnvObj.ingredients.merging(selectedIngredients, uniquingKeysWith: + )
                    save()
                    self.presentationMode.wrappedValue.dismiss()
                }
                .tint(.yellow)
                .foregroundColor(.black)
                
            }.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            
        }
    }
    
    private func save(){
        guard !selectedIngredients.isEmpty else { return; }
        
        for ingredients in selectedIngredients.values{
            selectedIngredientsEnvObj.append(ingredients)
        }
        favRecipes.recipes.append(recipe)
    }
    
}


struct IngredientView: View {
    @Binding var selectedIngredients: [String: Ingredient]
    
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
    
    var foodId: String {
        (ingredient.foodId != nil) ? ingredient.foodId! : ""
    }
    
    var isSelected: Bool {
        selectedIngredients[foodId] != nil
    }
    
    var body: some View {
        
        
        HStack{
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 75,height: 75)
            .clipShape(Circle())
            .overlay(
                Circle().if{
                    if(isSelected){
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
                .if(isSelected){
                    $0.foregroundColor(.mint)
                }
            
            Spacer()
            
            if(quantity != "0"){
                Text("| \(quantity) \(measurement)")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                    .fontWeight(.bold)
                    .textCase(.uppercase)
                    .if(isSelected){
                        $0.foregroundColor(.mint)
                    }
            }
        }.if{
            if(isSelected){
                $0.background(LinearGradient(gradient: Gradient(colors: [.yellow, .white]), startPoint: .trailing, endPoint: .leading).cornerRadius(50))
                    
            } else {
                $0
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeIn(duration: 0.5)){
                if(isSelected){
                    selectedIngredients.removeValue(forKey: foodId)
                }else{
                    selectedIngredients[foodId] = ingredient
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
//                    SimpleTimer()
//                        .frame(height: 60)
//                        .padding(4)
                    ZStack{
                        RecipeWebView(url: url)
                        Image(systemName: "hand.tap.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(AppColors.purple)
                            .position(x: 164, y: 60)
                            .frame(width: 40)
                          
                            
                    }
                        //.preferredColorScheme(.dark)
                }
            }
            .foregroundColor(.yellow)
        }
    }
}

struct SimpleTimer: View{
    var body: some View{
        VStack{
            Text("Start the timer when ready to Cook!")
                .font(.caption2)
            HStack{
                Spacer()
                Button {
                    startTimer()
                } label: {
                    ZStack{
                        Circle()
                            .frame(width: 50)
                            .foregroundColor(.green)
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                    }
                    
                }

                ZStack{
                    Rectangle()
                        .frame(width: .infinity)
                        .foregroundColor(AppColors.yellow)
                        .cornerRadius(70)
                    
                    Text(" 02:  30:  00 ")
                        .font(.title)
                    // .alignmentGuide(.center){_ in
                    //CGFloat(3)
                    //}
                }
                Spacer()
            }
        }
    }
    
    private func startTimer(){
        
    }
}

