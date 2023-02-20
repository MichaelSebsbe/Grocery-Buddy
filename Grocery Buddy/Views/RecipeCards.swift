//
//  Cards.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 12/30/22.
//

import SwiftUI

struct RecipieCards: View {
    var recipes: RecipeResponse?
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            if let recipes = recipes{
                
                let recipesCount = recipes.hits.count
                ForEach(0..<recipesCount, id: \.self) { index in
                    if let recipe = recipes.hits[index]?.recipe,
                       let imageURL = recipe.images["REGULAR"]!.url!,
                       let foodName = recipe.label{
                        let ingredients = recipe.ingredients
                        
                        NavigationLink(destination: RecipeDetailView(title: foodName, imageURL: imageURL, ingredients: ingredients).navigationBarBackButtonHidden()){
                            Card(recipe: recipe)
                            
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            } else{
                Text("search from our 10,000 recipes!")
            }
        }
        
    }
}


// MARK: - Front of card
struct Card: View {
    @State private var isFaceUp: Bool = true
    
    let recipe: Recipe
    
    var url: String{
        if let largeImage = recipe.images["LARGE"],
           let url = largeImage.url{
            return url
        }
        else if let mediumImage = recipe.images["REGULAR"],
                let url = mediumImage.url{
            
            return url
        } else if let smallImage = recipe.images["SMALL"],
                  let url = smallImage.url{
            
            return url
        }else {
            return "https://a.cdn-hotels.com/gdcs/production24/d1597/4f3f77cf-bdca-4ec3-af5d-ea923d74f672.jpg"
        }
    }
    
    var source: String{
        if let source = recipe.source{
            return "👨🏽‍🍳: " + source
        }else{
            return ""
        }
    }
    
    
    var body: some View {
        if (isFaceUp){
            VStack (alignment: .trailing){
                ZStack(alignment: .leading){
                    Color(red: 1, green: 0.8, blue: 0.2)
                        .cornerRadius(10)
                        .shadow(color: Color(red: 0.2, green: 0.28, blue: 0.30, opacity: 0.3), radius: 2, x: 5, y: 5)
                    
                    VStack {
                        HStack(alignment: .center){
                            AsyncImage(url: URL(string: url)) { image in
                                image.resizable()
                            } placeholder: {
                                
                             ProgressView()
                            }
                            .frame(width: 126.0, height: 126.0)
                            .cornerRadius(10)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))

                            InfoBox(recipe: recipe)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Text(source)
                    .multilineTextAlignment(.trailing)
                    .italic()
                    .font(.body)
                    .fontWeight(.light)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                
            }
//            .onTapGesture {
//                //navigate to details page
//            }
//            .gesture(LongPressGesture().onEnded({ _ in
//                isFaceUp.toggle()
//            }))
        }else{
            CardBack()
//                .onTapGesture {
//                    isFaceUp.toggle()
//                }
        }
    }

}

struct InfoBox: View {
    var recipe: Recipe
    var color: Color = .black
    //unwrapping all
    var label: String {
        if let label = recipe.label{
            return label
        } else {
            return "Misssing"
        }
    }
    
    var ingredientsCount: Int{
        recipe.ingredients.count
    }
    
    var calories: String{
        if let calories = recipe.calories{
            return "\(Int(round(calories)))"
        }else{
            return "N/A"
        }
    }
    
    var mealWeight: String {
        if let weight = recipe.totalWeight{
            return "\( Int( round(weight)))g"
        }
        return "-----g"
    }
    
    var region: String {
        guard let cusinesTypes = recipe.cuisineType else { return "" }
        
        var emojis = ""
        
        for cusine in cusinesTypes{
            switch cusine{
            case "american":
                emojis.append("🇺🇸")
                break
            case "asian", "Chinese":
                emojis.append("🌏")
                break
            case "british", "Central Europe":
                emojis.append("🌍")
                break
            case "caribbean":
                emojis.append("🏝")
                break
            case "french":
                emojis.append("🇫🇷")
                break
            case "indian":
                emojis.append("🇮🇳")
                break
            case "italian":
                emojis.append("🇮🇹")
                break
            case "japanese":
                emojis.append("🇯🇵")
                break
            case "kosher":
                emojis.append("🇮🇱")
                break
            case "mediterranean":
                emojis.append("🇬🇷")
                break
            case "mexican":
                emojis.append("🇲🇽")
                break
            case "middle Eastern":
                emojis.append("🇸🇦")
                break
            case "nordic":
                emojis.append("🇳🇴")
                break
            case "south America":
                emojis.append("🌎")
                break
            case "south East Asian":
                emojis.append("🇮🇩")
            default:
                break
            }
        }
        return emojis
    }
    var prepTime: String?{
        if let prepTime = recipe.totalTime{
            let hrs = prepTime / 60
            let mins = prepTime % 60
            switch (hrs, mins){
            case (0, 0):
                return nil
           
            case (0, _):
                return "\(mins)Mins"
              
            case (_, 0):
                return "\(hrs)Hrs"
            
            case (_, _):
                return "\(hrs)Hrs \(mins)Mins"
            
            }
        }
        return nil
    }
    //    var mealTypeImages:[any View] {
    //        var mealTypeImages = [any View]()
    //
    //        let count = mealTypeImages.count
    //
    //
    //        for mealType in recipe.mealType {
    //            guard let mealType = mealType else {
    //                mealTypeImages.append(Image(systemName: "exclamationmark.circle.fill")
    //                    .symbolRenderingMode(.palette)
    //                    .foregroundStyle(.white, .pink))
    //
    //                continue
    //            }
    //
    //            switch(mealType){
    //                case "breakfast":
    //                mealTypeImages.append(Image(systemName: "sunrise.fill")
    //                    .symbolRenderingMode(.multicolor))
    //
    //                case "lunch/dinner", "dinner":
    //                mealTypeImages.append(Image(systemName: "moon.circle.fill")
    //                    .symbolRenderingMode(.palette)
    //                    .foregroundStyle(.white, .pink))
    //
    //                case "lunch":
    //                mealTypeImages.append(Image(systemName: "sun.max.fill")
    //                    .symbolRenderingMode(.multicolor)
    //                    .foregroundStyle(.white, .pink))
    //
    //                case "snack":
    //                mealTypeImages.append(Image(systemName: "s.circle.fill")
    //                        .symbolRenderingMode(.palette)
    //                        .foregroundStyle(.white, .pink))
    //
    //            case "teatime":
    //                mealTypeImages.append(Image(systemName: "custom.cup.and.saucer.fill")
    //                    .foregroundColor(.pink)
    //                    .symbolRenderingMode(.hierarchical))
    //
    //
    //            default:
    //                mealTypeImages.append(Image(systemName: "custom.cup.and.saucer.fill")
    //                    .foregroundColor(.pink)
    //                    .symbolRenderingMode(.hierarchical))
    //
    //            }
    //        }
    //
    //        return mealTypeImages
    //
    //    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 7.0){
            Text(label)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(color)
                .lineLimit(2)
                .minimumScaleFactor(0.3)
                .textCase(.uppercase)
                //.shadow(color: .white, radius: 4, x: 0, y: 0)
            //.padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 0))
            
            HStack(alignment: .center, spacing: 14){
                
                MealSymbols(recipe: recipe)
                    .font(.title2)
                    .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 0))
                //lunch,dinner,bf
                
                HealthSymbols(healthLabels: recipe.healthLabels)
                    .font(.title2)
                //                Image(systemName: "leaf.circle.fill")
                //                //.foregroundColor(Color(red: 0.02, green: 0.87, blue: 0.62))
                //
                //                    .symbolRenderingMode(.palette)
                //                    .foregroundStyle(.white, Color(red: 0.02, green: 0.87, blue: 0.62))
                //                Image(systemName: "leaf.circle.fill")
                //                //.foregroundColor(.yellow)
                //                    .font(.title2)
                //                    .symbolRenderingMode(.palette)
                //                    .foregroundStyle(.white, .yellow)
                
                Text(region)
                    .font(.title2)
                    .foregroundColor(Color(red: 0.2, green: 0.0, blue: 0.6))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 6))
                
                //                Image(systemName: "globe.americas.fill")
                //                    .font(.title2)
                //                    .foregroundColor(Color(red: 0.2, green: 0.0, blue: 0.6))
                //                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 6))
                
                // Text("🇺🇸")
                //     .font(.title)
            }
            .padding(2)
            .background(Color(red: 0.6, green: 0.4, blue: 0.6))
            .cornerRadius(23)
            
            
            
            HStack(alignment: .center, spacing: 23.0) {
                Label("\(ingredientsCount)", systemImage: "cart.fill.badge.plus")
                //.foregroundColor(Color(red: 01, green: 0.35, blue: 0.4))
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color(red: 01, green: 0.35, blue: 0.4), .white)
                
                if let prepTime = prepTime{
                    Label(prepTime, systemImage: "hourglass")
                        .font(.body)
                        //.fontWeight(.light)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, Color(red: 0.02, green: 0.87, blue: 0.62))
                        //.shadow(color: Color(red: 1, green: 1, blue: 1), radius: 1.2, x: 0, y: 0)
                }
            }
            
            HStack (alignment: .center, spacing: 13.0){
                Label(calories, systemImage: "bolt.circle.fill")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .symbolRenderingMode(.palette)
                    .italic()
                    .foregroundStyle(.white, Color(red: 0.02, green: 0.87, blue: 0.62))
                
                Label(mealWeight, systemImage: "scalemass.fill")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .italic()
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color(red: 01, green: 0.35, blue: 0.4), .white, .white)
                
            }
            
        }
    }
    
}

//class InfoBoxVM {
//    let recipe: Recipe
//
//    init(recipe: Recipe) {
//        self.recipe = recipe
//    }
//
//    var healthLables:[String]{
//        guard let healthLabels = recipe.healthLabels else{return [String]()}
//
//        var labels = [String]()
//
//        for i in  0..<healthLabels.count {
//            let label = healthLabels[i]
//            switch(label){
//            case "Gluten-Free", "Keto-Friendly", "Kosher", "Vegan", "Vegetarian":
//                labels.append(label)
//            default:
//                continue
//            }
//        }
//
//        return labels
//    }
//}
//

struct HealthSymbols: View{
    var healthLabels: [String]?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                if let healthLabels = healthLabels{
                    ForEach(0..<healthLabels.count, id: \.self) { i in
                        let healthLabel = healthLabels[i]
                        
                        switch (healthLabel){
                        case "Keto-Friendly":
                            Image(systemName: "k.square.fill")
                                .symbolRenderingMode(.multicolor)
                                .foregroundColor(.cyan)
                        case "Gluten-Free":
                            Image(systemName: "g.square.fill")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.black, .white)
                        case "Kosher":
                            Image(systemName: "kipsign.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .foregroundColor(.cyan)
                        case  "Vegan":
                            Image(systemName: "leaf.fill")
                                .symbolRenderingMode(.monochrome)
                                .foregroundColor(.yellow)
                        case "Vegetarian":
                            Image(systemName: "leaf.fill")
                                .symbolRenderingMode(.multicolor)
                                .foregroundColor(.green)
                        case "Pescatarian":
                            Image(systemName: "fish.fill")
                                .symbolRenderingMode(.monochrome)
                                .foregroundColor(.yellow)
                            
                        default:
                            EmptyView()
                            //                        Image(systemName: "q.square.fill")
                            //                            .symbolRenderingMode(.multicolor)
                            //                            .foregroundColor(.cyan)
                        }
                        
                    }
                }
            }
        }
        
    }
}

struct MealSymbols: View{
    var recipe: Recipe
    
    var body: some View{
        
        HStack(spacing: -10) {
            ForEach(0..<recipe.mealType.count, id: \.self) { i in
                let mealType = recipe.mealType[i]
                
                if (mealType == nil){
                    Image(systemName: "exclamationmark.circle.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .pink)
                    
                } else {
                    switch(mealType){
                    case "breakfast":
                        Image(systemName: "sunrise.fill")
                            .symbolRenderingMode(.multicolor)
                        
                    case "lunch/dinner":
                        Image(systemName: "moon.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .pink)
                        
                        Image(systemName: "sun.max.fill")
                            .symbolRenderingMode(.multicolor)
                            .foregroundStyle(.white, .pink)
                        
                        
                    case "dinner":
                        Image(systemName: "moon.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .pink)
                        
                    case "lunch":
                        Image(systemName: "sun.max.fill")
                            .symbolRenderingMode(.multicolor)
                            .foregroundStyle(.white, .pink)
                        
                    case "snack":
                        Image(systemName: "popcorn.fill")
                            .symbolRenderingMode(.multicolor)
                            .foregroundStyle(.yellow)
                        
                    case "teatime":
                        Image(systemName: "cup.and.saucer.fill")
                            .foregroundColor(.pink)
                            .symbolRenderingMode(.hierarchical)
                        
                        
                    default:
                        Image(systemName: "cup.and.saucer.fill")
                            .foregroundColor(.pink)
                            .symbolRenderingMode(.hierarchical)
                        
                    }
                }
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
