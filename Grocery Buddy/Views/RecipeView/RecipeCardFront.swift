//
//  RecipeCard.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 3/7/23.
//

import SwiftUI

struct RecipeCardFront: View {
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
                            
                            InfoBox(isFaceUp: $isFaceUp, recipe: recipe)
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
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                
            }
//            .onTapGesture {
//                //
//            }
//            .onLongPressGesture(perform: {
//                isFaceUp.toggle()
//            })

        }else{
            if let totalWeight = recipe.totalWeight,
               let totalNutrients = recipe.totalNutrients,
               let totalDaily = recipe.totalDaily{
                CardBack(totalWeight: totalWeight, totalNutrients: totalNutrients, totalDaily: totalDaily)
                    .onTapGesture {
                        isFaceUp.toggle()
                    }
                
            }
        }
    }

}



struct InfoBox: View {
    @Binding var isFaceUp: Bool
    var recipe: Recipe
    var color: Color = .black
    
    //unwrapping all
    var label: String {
        if let label = recipe.label{
            return label
        } else {
            return "Missing"
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
            let hrs = Int(prepTime / 60)
            //let mins = prepTime % 60
            let  mins = Int(prepTime.truncatingRemainder(dividingBy: 60.0))
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
    
    @State private var isAnimating = false
    var body: some View {
        
        VStack(alignment: .leading, spacing: 7.0){
            Text(label)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(color)
                .lineLimit(2)
                .minimumScaleFactor(0.3)
                .textCase(.uppercase)
            
            HStack(alignment: .center, spacing: 14){
                
                MealSymbols(recipe: recipe)
                    .font(.title2)
                    .padding(.leading, 7)
                //lunch,dinner,bf
                
                HealthSymbols(healthLabels: recipe.healthLabels)
                    .font(.title2)
            
                
                Text(region)
                    .font(.title2)
                    .foregroundColor(Color(red: 0.2, green: 0.0, blue: 0.6))
                    .padding(.trailing, 6)
       
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
            
            HStack (alignment: .center, spacing: 8.0){
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
                Spacer(minLength: 0)
                Button {
                    //flips the card
                    isFaceUp = false;
                } label: {
                    Image(systemName: "arrow.down.right.square.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, .white)
                        .font(.title)
                }
                
            }
            
        }
    }
    
}


struct HealthSymbols: View {
    var healthLabels: [String]?
    var sanitizedHealthLabels: [String]?{
        let neededLabels = ["Keto-Friendly", "Gluten-Free", "Kosher", "Vegan", "Vegetarian", "Pescatarian", "Dairy-Free"]
        
        if var sanitizedHealtLabels = healthLabels{
            sanitizedHealtLabels = sanitizedHealtLabels.filter({ label in
                neededLabels.contains(label)
            })
            
            return sanitizedHealtLabels
        }
        
        return nil
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                if let healthLabels = sanitizedHealthLabels{
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
