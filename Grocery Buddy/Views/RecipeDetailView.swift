//
//  RecipeDetailView.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 2/8/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let title: String
    let imageURL: String
    let ingredients: [Ingredient]
    @State private var selected: Int = 0
    //let ingredients: [String]
    var body: some View {
        VStack{
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 30))
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            ZStack{
                Rectangle()
                    .foregroundColor(.yellow)
                    .cornerRadius(20)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                
                VStack() {
                    HStack (alignment: .center){
                        
                        Text(title)
                            .font(.system(size:37))
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
                            .frame(width: 3, height: 125)
                            .overlay(.white)
                        
                        AsyncImage(url: URL(string: imageURL)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 125,height: 125)
                        .cornerRadius(15)
                        
                        //.font(.)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    Divider()
                        .frame(height: 3)
                        .overlay(.black)
                        .padding(EdgeInsets(top: -19, leading: 0, bottom: 0, trailing: 0))
                    
                    ScrollView(.vertical, showsIndicators: false){
                        ForEach(ingredients, id: \.self.foodId){ ingredient in
                            IngredientView(selectCount: $selected, ingredient: ingredient)
                            
                        }
                        .padding(.top, 4)
                    }.ignoresSafeArea()
                        .padding(.top, -24)
                    
                    
                    Spacer()
                }.padding(EdgeInsets(top: 15, leading: 30, bottom: -8, trailing: 30))
                
                
            }
            HStack{
                Button("Add All") {
                    //add all ingridents to grocery cart
                }
                
                Text("\(selected) out of \(ingredients.count)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .fontWeight(.semibold)
                Button("Done"){
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
    //    let ingredients = [Ingredient(text: "Mayonnaise", quantity: 2.5, measure: "Cups", food: "Mayonnaise", weight: 3, foodCategory: "dsf", foodId: "22", image: "https://i2-prod.dailystar.co.uk/incoming/article23201324.ece/ALTERNATES/s615b/0_Bowl-of-mayonnaise-with-spoon-embedded-view-from-above.jpg")]
    
    //    var ingredients: [Ingredient] {
    //        [ingredient, ingredient, ingredient, ingredient, ingredient, ingredient]
    //    }
    
    static var previews: some View {
        RecipeDetailView(title:"12345 7890 2345 789 123456 89", imageURL:"https://www.tasteofhome.com/wp-content/uploads/2018/01/exps28800_UG143377D12_18_1b_RMS.jpg", ingredients: [
            Ingredient(text: "Mayonnaise", quantity: 2.5, measure: "Cups", food: "Mayonnaise with shshsd", weight: 3, foodCategory: "dsf", foodId: "22", image: "https://i2-prod.dailystar.co.uk/incoming/article23201324.ece/ALTERNATES/s615b/0_Bowl-of-mayonnaise-with-spoon-embedded-view-from-above.jpg"),
            Ingredient(text: "Mayonnaise", quantity: 2.5, measure: "Cups", food: "Mayonnaise", weight: 3, foodCategory: "dsf", foodId: "23", image: "https://i2-prod.dailystar.co.uk/incoming/article23201324.ece/ALTERNATES/s615b/0_Bowl-of-mayonnaise-with-spoon-embedded-view-from-above.jpg"),
            Ingredient(text: "Mayonnaise", quantity: 2.5, measure: "Cups", food: "Mayonnaise", weight: 3, foodCategory: "dsf", foodId: "24", image: "https://i2-prod.dailystar.co.uk/incoming/article23201324.ece/ALTERNATES/s615b/0_Bowl-of-mayonnaise-with-spoon-embedded-view-from-above.jpg"),
            Ingredient(text: "Mayonnaise", quantity: 2.5, measure: "Cups", food: "Mayonnaise", weight: 3, foodCategory: "dsf", foodId: "25", image: "https://i2-prod.dailystar.co.uk/incoming/article23201324.ece/ALTERNATES/s615b/0_Bowl-of-mayonnaise-with-spoon-embedded-view-from-above.jpg"),
            Ingredient(text: "Mayonnaise", quantity: 2.5, measure: "Cups", food: "Mayonnaise", weight: 3, foodCategory: "dsf", foodId: "23", image: "https://i2-prod.dailystar.co.uk/incoming/article23201324.ece/ALTERNATES/s615b/0_Bowl-of-mayonnaise-with-spoon-embedded-view-from-above.jpg"),
            Ingredient(text: "Mayonnaise", quantity: 2.5, measure: "Cups", food: "Mayonnaise", weight: 3, foodCategory: "dsf", foodId: "23", image: "https://i2-prod.dailystar.co.uk/incoming/article23201324.ece/ALTERNATES/s615b/0_Bowl-of-mayonnaise-with-spoon-embedded-view-from-above.jpg")
            
        ] ).previewDevice("iPhone 14")
        
    }
    
}

struct IngredientView: View {
    @State private var isSelected = false
    @Binding var selectCount: Int
    var ingredient: Ingredient
    var imageURL: String {
        ingredient.image ?? "default image url"
    }
    var label: String {
        ingredient.food ?? "****************Missing Data****************"
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
                    Circle()
                        .if{
                            if(isSelected){
                                $0.stroke(Color.mint,lineWidth:5)
                            } else {
                                $0.stroke(Color.white,lineWidth:5)
                            }
                        }
                        
                )
          //  } else {
//                AsyncImage(url: URL(string: imageURL)) { image in
//                    image.resizable()
//                } placeholder: {
//                    ProgressView()
//                }
//                .frame(width: 75,height: 75)
//                .clipShape(Circle())
//                .overlay(
//                    Circle()
//                        .stroke(Color.white,lineWidth:5)
//                )
           // }
            
            Text(label)
                .font(.system(size: 20))
                .textCase(.uppercase)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .minimumScaleFactor(0.4)
            Spacer()
            
            if(quantity != "0"){
                Text("| \(quantity) \(measurement)")
                    .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                    .fontWeight(.semibold)
                    .textCase(.uppercase)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
        .onTapGesture {
            isSelected.toggle()
            if(isSelected){
                selectCount += 1
            }else{
                selectCount -= 1
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
