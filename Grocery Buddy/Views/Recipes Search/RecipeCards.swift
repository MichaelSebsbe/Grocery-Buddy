//
//  Cards.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 12/30/22.
//

import SwiftUI


struct RecipieCards: View {
    @Binding var recipes: RecipeResponse?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack{
                if let recipes = recipes,
                   let hits = recipes.hits{
                    List(hits) { hit in
                        if let hit = hit,
                            let recipe = hit.recipe {
                            Card(recipe: recipe)
                        }
                    }
                    
                    //Card()
                } else{
                    CardBack()
                }
                
            }
        }
    }
}


// MARK: - Front of card
struct Card: View {
    @State var recipe: Recipe
    
    
    var body: some View {
        VStack (alignment: .trailing){
            ZStack(alignment: .leading){
                Color(red: 1, green: 0.8, blue: 0.2)
                    .cornerRadius(10)
                    .shadow(color: Color(red: 0.2, green: 0.28, blue: 0.30, opacity: 0.3), radius: 2, x: 5, y: 5)
                
                VStack {
                    HStack(alignment: .center){
                        Image("cheese")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 126.0)
                            .cornerRadius(10)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))

                        if let title = recipe.label{
                            InfoBox(title: title)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                        } else{
                            InfoBox(title: "Missing")
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                        }
                        
                    }
                    
                }
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            Text("👨🏽‍🍳 ﹫mike_mulu")
                .multilineTextAlignment(.trailing)
                .italic()
                .font(.body)
                .fontWeight(.light)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
            
        }
        
    }
}

struct InfoBox: View {
    var title: String
    var color: Color = .black
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7.0){
            
            Text(title)
                .font(.title2)
                .fontWeight(.light)
                .foregroundColor(color)
                .lineLimit(2)
                .minimumScaleFactor(0.6)
                .shadow(color: .white, radius: 4, x: 0, y: 0)
            //.padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 0))
            
            HStack(alignment: .center, spacing: 17.0){
                //ingredints
                Image(systemName: "sunrise.fill")
                    .foregroundColor(.black)
                    .font(.title2)
                    .symbolRenderingMode(.multicolor)
                    .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 0))
                Image(systemName: "leaf.circle.fill")
                //.foregroundColor(Color(red: 0.02, green: 0.87, blue: 0.62))
                    .font(.title2)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, Color(red: 0.02, green: 0.87, blue: 0.62))
                Image(systemName: "leaf.circle.fill")
                //.foregroundColor(.yellow)
                    .font(.title2)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .yellow)
                Image(systemName: "globe.americas.fill")
                    .font(.title2)
                    .foregroundColor(Color(red: 0.2, green: 0.0, blue: 0.6))
                // Text("🇺🇸")
                //     .font(.title)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 6))
            }
            .padding(2)
            .background(Color(red: 0.6, green: 0.4, blue: 0.6))
            .cornerRadius(23)
            
            
            
            HStack(alignment: .center, spacing: 23.0) {
                Label("9", systemImage: "cart.fill.badge.plus")
                //.foregroundColor(Color(red: 01, green: 0.35, blue: 0.4))
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color(red: 01, green: 0.35, blue: 0.4), .white)
                
                Label("1:40", systemImage: "hourglass")
                    .font(.body)
                    .fontWeight(.medium)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, Color(red: 0.02, green: 0.87, blue: 0.62))
                    .shadow(color: Color(red: 1, green: 1, blue: 1), radius: 1.2, x: 0, y: 0)
                
                
                
            }
            
            HStack (alignment: .center, spacing: 13.0){
                Label("10,000", systemImage: "bolt.circle.fill")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .symbolRenderingMode(.palette)
                    .italic()
                    .foregroundStyle(.white, Color(red: 0.02, green: 0.87, blue: 0.62))
                
                Label("8", systemImage: "fork.knife.circle.fill")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .italic()
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color(red: 01, green: 0.35, blue: 0.4), .white, .white)
                
            }
            
        }
    }
    
}

// MARK: - Back of Card

struct CardBack: View {
    var body: some View {
        VStack (alignment: .trailing){
            ZStack(alignment: .leading){
                Color(red: 1, green: 0.8, blue: 0.2)
                    .cornerRadius(10)
                    .shadow(color: Color(red: 0.2, green: 0.28, blue: 0.30, opacity: 0.3), radius: 2, x: 5, y: 5)
                
                HStack(spacing: 8) {
                    NutrionalFacts(servings: 8, servingSize: 200, calories: 250)
                    try! NFRow2(labels: [
                        "Tot.Fat",
                        "Cole",
                        "Sodiu",
                        "Tot.Carb",
                        "Prot"
                    ], weights: [
                        "8g",
                        "0mg",
                        "160mg",
                        "37g",
                        "3g"
                    ])
                    try! NFRow3(labels: [
                        "Protein",
                        "Vita D",
                        "Calci.",
                        "Iron",
                        "Potass"
                    ], weights: [
                        "8g",
                        "2mcg",
                        "260mg",
                        "8mg",
                        "240mg"
                    ])
                    
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
        }
        
    }
}


struct Nutrition: View {
    let label: String
    let amount: String
    let bold: Bool
    
    init(label: String, amount: String, bold: Bool = true ) {
        self.label = label
        self.amount = amount
        self.bold = bold
    }
    
    var body: some View {
        HStack{
            Text(label)
                .font(.footnote)
                .fontWeight(bold ? .bold : .regular)
                .lineLimit(1)
                .minimumScaleFactor(0.3)
            Text(amount)
                .font(.footnote)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Spacer()
            Text("10%")
                .font(.footnote)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}

// MARK: Nutritional Facts

struct NutrionalFacts: View {
    let servings: Int
    let servingSize: Int
    let calories: Int
    
    
    var body: some View {
        //column One
        VStack(alignment: .leading, spacing: 0){
            Text("Nutritional Facts")
                .fontWeight(.heavy)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            Rectangle()
                .frame(height: 0.5)
            
            Text("\(servings) servings")
                .fontWeight(.light)
                .font(.caption2)
            
            
            HStack{
                Text("Serving size")
                    .font(.footnote)
                    .fontWeight(.bold)
                Spacer()
                Text("\(servingSize)g")
                    .font(.footnote)
            }
            
            Rectangle()
                .frame(height: 6)
            
            Text("Amount per serving")
                .font(.caption2)
            
            HStack{
                Text("Calories")
                    .font(.footnote)
                    .fontWeight(.bold)
                Spacer()
                Text("\(calories)")
                    .font(.footnote)
            }
            
            Rectangle()
                .frame(height: 2)
            
            HStack{
                Spacer()
                Text("% Daily Value*")
                    .font(.caption2)
                    .fontWeight(.bold)
            }
        }
    }
}

struct NutritionFactsDetail: View {
    let label: String
    let amount: String
    let percentage: Int
    let indentTwice: Bool
    var indent: String {
        return indentTwice ? "      " : "   "
    }
    
    init(label: String, amount: String, percentage: Int, indentTwice: Bool = false){
        self.label = label
        self.amount = amount
        self.percentage = percentage
        self.indentTwice = indentTwice
    }
    
    var body: some View{
        HStack(spacing: 0){
            Text("\(indent)\(label)")
                .font(.footnote)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text("   \(amount)")
                .font(.footnote)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Spacer()
            Text("\(percentage)%")
                .font(.footnote)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}

struct NFRow2: View {
    
    enum NFRowError: Error {
        case labelAndWeightsMisMatch
    }
    
    let labels: [String]
    let weights: [String]
    
    init(labels: [String], weights: [String]) throws {
        guard labels.count == weights.count,
              labels.count == 5 else { throw NFRowError.labelAndWeightsMisMatch }
        
        self.labels = labels
        self.weights = weights
    }
    
    var body: some View {
        //column One
        VStack(alignment: .leading, spacing: 0){
            Group{
                Rectangle()
                    .frame(height: 0.5)
                
                Nutrition(label: labels[0], amount: weights[0])
                Rectangle()
                    .frame(height: 0.5)
                
                NutritionFactsDetail(label: "S.Fat", amount: "1g", percentage: 7)
                Rectangle()
                    .frame(height: 0.5)
                
                NutritionFactsDetail(label: "T.Fat", amount: "1g", percentage: 0)
                Rectangle()
                    .frame(height: 0.5)
                
                Nutrition(label: labels[2], amount: weights[2])
                Rectangle()
                    .frame(height: 0.5)
                
                
            }
            
            Group{
                Nutrition(label: labels[3], amount: weights[3])
                Rectangle()
                    .frame(height: 0.5)
                
                NutritionFactsDetail(label: "D.Fibery", amount: "1g", percentage: 14)
                Rectangle()
                    .frame(height: 0.5)
                
                NutritionFactsDetail(label: "Tot.Sug", amount: "1g", percentage: 14)
                Rectangle()
                    .frame(height: 0.5)
                
                NutritionFactsDetail(label: "Add.Sug", amount: "1g", percentage: 14 , indentTwice: true)
            }
            
            
        }
        
    }
}

struct NFRow3: View {
    
    enum NFRowError: Error {
        case labelAndWeightsMisMatch
    }
    
    let labels: [String]
    let weights: [String]
    
    init(labels: [String], weights: [String]) throws {
        guard labels.count == weights.count,
              labels.count == 5 else { throw NFRowError.labelAndWeightsMisMatch }
        
        self.labels = labels
        self.weights = weights
    }
    
    var body: some View {
        //column One
        VStack(alignment: .leading, spacing: 0){
            Group{
                Rectangle()
                    .frame(height: 0.5)
                
                Nutrition(label: labels[0], amount: weights[0])
                Rectangle()
                    .frame(height: 6)
                
                Nutrition(label: labels[1], amount: weights[1], bold: false)
                Rectangle()
                    .frame(height: 0.5)
                
                Nutrition(label: labels[2], amount: weights[2], bold: false)
                Rectangle()
                    .frame(height: 0.5)
                
                Nutrition(label: labels[3], amount: weights[3], bold: false)
                Rectangle()
                    .frame(height: 0.5)
                
                Nutrition(label: labels[4], amount: weights[4], bold: false)
            }
            
            Group{
                Rectangle()
                    .frame(height: 2)
                Text("*The % Daily Value tells you how much a nutrient in a serving of food contributes to a daily diet. 2000 calories a day is used for general nutrition advice.")
                    .font(.caption2)
                    .fontWeight(.light)
                    .lineLimit(/*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.6)
                    
            }
            
            
        }
        
    }
}
