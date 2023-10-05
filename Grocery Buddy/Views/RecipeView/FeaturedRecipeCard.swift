//
//  FeaturedRecipeCard.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 6/19/23.
//

import SwiftUI

struct FeaturedRecipeCard: View {
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
        let ingredients = recipe.ingredients
        NavigationLink(destination: RecipeDetailView(recipe: recipe)
            .navigationBarBackButtonHidden()){
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
                                
                                FeaturedInfoBox(recipe: recipe)
                                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                            }
                            
                            if let totalWeight = recipe.totalWeight,
                               let totalNutrients = recipe.totalNutrients,
                               let totalDaily = recipe.totalDaily{
                                FeaturedCardBack(totalWeight: totalWeight, totalNutrients: totalNutrients, totalDaily: totalDaily)
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
                
            }.buttonStyle(PlainButtonStyle())
        
    }
}

struct FeaturedInfoBox: View {
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
                
            }
            
        }
    }
    
}

//
//  RecipeCardBack.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 3/7/23.
//

import SwiftUI

struct FeaturedCardBack: View {
    let totalWeight: Float
    let totalNutrients: [String: NutrientsInfo]
    let totalDaily: [String:NutrientsInfo]
    let servingSize = 200
    
    var servings: String {
        "\( Int(round(totalWeight / Float(servingSize))) )"
    }
    
    var calories: String {
        if let info = totalNutrients["ENERC_KCAL"],
           let total = info.quantity{
            let perServing = Int(round(Float(servingSize) * total / totalWeight))
            return "\(perServing)"
        }
        return "N/A"
    }
    
    var totalFat: String {
        if let info = totalNutrients["FAT"],
           let total = info.quantity,
           let unit = info.unit{
            let perServing = Int(round(Float(servingSize) * total / totalWeight))
            return "\(perServing)\(unit)"
        }
        return "N/A"
    }
    
    var totalFatPercentage: Int {
        if let info = totalDaily["FAT"],
           let total = info.quantity{
            return Int(round(Float(servingSize)) * total / totalWeight)
        }
        return -1
    }
    
    var saturatedFat: String {
        if let info = totalNutrients["FASAT"],
           let total = info.quantity,
           let unit = info.unit{
            let perServing = Int(round(Float(servingSize) * total / totalWeight))
            return "\(perServing)\(unit)"
        }
        return "N/A"
    }
    
    var saturatedFatPercentage: Int {
        if let info = totalDaily["FASAT"],
           let total = info.quantity{
            return Int(round(Float(servingSize)) * total / totalWeight)
        }
        return -1
    }
    
    var transFat: String {
        if let info = totalNutrients["FATRN"],
           let total = info.quantity,
           let unit = info.unit{
            let perServing = round ( (Float(servingSize) * total / totalWeight) * 100 ) / 100.0
            return "\(perServing)\(unit)"
        }
        return "N/A"
    }
    
    var cholesterol: String {
        if let info = totalNutrients["CHOLE"],
           let total = info.quantity,
           let unit = info.unit{
            let perServing = Int(round(Float(servingSize) * total / totalWeight))
            return "\(perServing)\(unit)"
        }
        return "N/A"
    }
    
    var cholesterolPercentage: Int {
        if let info = totalDaily["CHOLE"],
           let total = info.quantity{
            return Int(round(Float(servingSize)) * total / totalWeight)
        }
        return -1
    }
    
    var sodium: String {
        if let info = totalNutrients["NA"],
           let total = info.quantity,
           let unit = info.unit{
            let perServing = Int(round(Float(servingSize) * total / totalWeight))
            return "\(perServing)\(unit)"
        }
        return "N/A"
    }
    
    var sodiumPercentage: Int {
        if let info = totalDaily["NA"],
           let total = info.quantity{
            return Int(round(Float(servingSize)) * total / totalWeight)
        }
        return -1
    }
    
    
    var carbs: String {
        if let info = totalNutrients["CHOCDF"],
           let total = info.quantity,
           let unit = info.unit{
            let perServing = Int(round(Float(servingSize) * total / totalWeight))
            return "\(perServing)\(unit)"
        }
        return "N/A"
    }
    
    var carbsPercentage: Int {
        if let info = totalDaily["CHOCDF"],
           let total = info.quantity{
            return Int(round(Float(servingSize)) * total / totalWeight)
        }
        return -1
    }
    
    var fiber: String {
        if let info = totalNutrients["FIBTG"],
           let total = info.quantity,
           let unit = info.unit{
            let perServing = Int(round(Float(servingSize) * total / totalWeight))
            return "\(perServing)\(unit)"
        }
        return "N/A"
    }
    
    var fiberPercentage: Int {
        if let info = totalDaily["FIBTG"],
           let total = info.quantity{
            return Int(round(Float(servingSize)) * total / totalWeight)
        }
        return -1
    }
    
    var totalSugar: String {
        if let info = totalNutrients["SUGAR"],
           let total = info.quantity,
           let unit = info.unit{
            let perServing = Int(round(Float(servingSize) * total / totalWeight))
            return "\(perServing)\(unit)"
        }
        return "N/A"
    }
    
    var additionalSugar: String {
        if let info = totalNutrients["SUGAR.added"],
           let total = info.quantity,
           let unit = info.unit{
            let perServing = Int(round(Float(servingSize) * total / totalWeight))
            return "\(perServing)\(unit)"
        }
        return "N/A"
    }
    
    
    
    var protein: String {
        if let info = totalNutrients["PROCNT"],
           let total = info.quantity,
           let unit = info.unit{
            let perServing = Int(round(Float(servingSize) * total / totalWeight))
            return "\(perServing)\(unit)"
        }
        return "N/A"
    }
    
    var proteinPercentage: Int {
        if let info = totalDaily["PROCNT"],
           let total = info.quantity{
            return Int(round(Float(servingSize)) * total / totalWeight)
        }
        return -1
    }
    
    var vitaminD: String {
        if let info = totalNutrients["VITD"],
           let total = info.quantity,
           let unit = info.unit{
            let perServing = round ( (Float(servingSize) * total / totalWeight) * 100 ) / 100.0
            return "\(perServing)\(unit)"
        }
        return "N/A"
    }
    
    var vitaminDPercentage: Int {
        if let info = totalDaily["VITD"],
           let total = info.quantity{
            return Int(round(Float(servingSize)) * total / totalWeight)
        }
        return -1
    }
    
    var calcium: String {
        if let info = totalNutrients["CA"],
           let total = info.quantity,
           let unit = info.unit{
            let perServing = Int(round(Float(servingSize) * total / totalWeight))
            return "\(perServing)\(unit)"
        }
        return "N/A"
    }
    
    var calciumPercentage: Int {
        if let info = totalDaily["CA"],
           let total = info.quantity{
            return Int(round(Float(servingSize)) * total / totalWeight)
        }
        return -1
    }
    
    var iron: String {
        if let info = totalNutrients["FE"],
           let total = info.quantity,
           let unit = info.unit{
            let perServing = Int(round(Float(servingSize) * total / totalWeight))
            return "\(perServing)\(unit)"
        }
        return "N/A"
    }
    
    var ironPercentage: Int {
        if let info = totalDaily["FE"],
           let total = info.quantity{
            return Int(round(Float(servingSize)) * total / totalWeight)
        }
        return -1
    }
    
    var potassium: String {
        if let info = totalNutrients["K"],
           let total = info.quantity,
           let unit = info.unit{
            let perServing = Int(round(Float(servingSize) * total / totalWeight))
            return "\(perServing)\(unit)"
        }
        return "N/A"
    }
    
    var potassiumPercentage: Int {
        if let info = totalDaily["K"],
           let total = info.quantity{
            return Int(round(Float(servingSize)) * total / totalWeight)
        }
        return -1
    }
    
    var body: some View {
        VStack (alignment: .trailing){
            ZStack(alignment: .leading){
                HStack(spacing: 8) {
                    NFColumn1(servings: servings, servingSize: servingSize, calories: calories)
                    try! NFColumn2(labels: [
                        "Tot.Fat",
                        "S.Fat",
                        "T.fat",
                        "Cole",
                        "Sodiu",
                        "Tot.Carb",
                        "D.Fiber",
                        "Tot.Sug",
                        "Add.sug"
                    ], weights: [
                        totalFat,
                        saturatedFat,
                        transFat,
                        cholesterol,
                        sodium,
                        carbs,
                        fiber,
                        totalSugar,
                        additionalSugar
                    ], percentages: [
                        totalFatPercentage,
                        saturatedFatPercentage,
                        -1,
                        cholesterolPercentage,
                        sodiumPercentage,
                        carbsPercentage,
                        fiberPercentage,
                        -1,
                        -1])
                    
                    try! NFColumn3(labels: [
                        "Protein",
                        "Vita D",
                        "Calci.",
                        "Iron",
                        "Potass"
                    ], weights: [
                        protein,
                        vitaminD,
                        calcium,
                        iron,
                        potassium
                    ], percentages: [
                        proteinPercentage,
                        vitaminDPercentage,
                        calciumPercentage,
                        ironPercentage,
                        potassiumPercentage])
                    
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
        }
        
    }
}


