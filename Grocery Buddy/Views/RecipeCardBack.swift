//
//  RecipeCardBack.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 3/7/23.
//

import SwiftUI

struct CardBack: View {
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
                Color(red: 1, green: 0.8, blue: 0.2)
                    .cornerRadius(10)
                    .shadow(color: Color(red: 0.2, green: 0.28, blue: 0.30, opacity: 0.3), radius: 2, x: 5, y: 5)
                
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


struct Nutrition: View {
    let label: String
    let amount: String
    let bold: Bool
    let percentage: Int
    
    init(label: String, amount: String, bold: Bool = true, percentage: Int ) {
        self.label = label
        self.amount = amount
        self.bold = bold
        self.percentage = percentage
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
            if(percentage != -1 ){
                Text("\(percentage)%")
                    .font(.footnote)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
        }
    }
}

// MARK: Nutritional Facts

struct NFColumn1: View {
    let servings: String
    let servingSize: Int
    let calories: String
    
    
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
            //-1 means not needed
            if(percentage != -1){
                Text("\(percentage)%")
                    .font(.footnote)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
        }
    }
}

struct NFColumn2: View {
    
    enum NFRowError: Error {
        case labelAndWeightsMisMatch
    }
    
    let labels: [String]
    let weights: [String]
    let percentages: [Int]
    
    
    init(labels: [String], weights: [String], percentages: [Int]) throws {
        guard labels.count == weights.count,
              labels.count == 9 else { throw NFRowError.labelAndWeightsMisMatch }
        
        self.labels = labels
        self.weights = weights
        self.percentages = percentages
    }
    
    var body: some View {
        //column One
        VStack(alignment: .leading, spacing: 0){
            Group{
                Rectangle()
                    .frame(height: 0.5)
                
                Nutrition(label: labels[0], amount: weights[0], percentage: percentages[0])
                Rectangle()
                    .frame(height: 0.5)
                
                NutritionFactsDetail(label: labels[1], amount: weights[1], percentage: percentages[1])
                Rectangle()
                    .frame(height: 0.5)
                
                NutritionFactsDetail(label: labels[2], amount: weights[2], percentage: percentages[2])
                Rectangle()
                    .frame(height: 0.5)
                Nutrition(label: labels[3], amount: weights[3], percentage: percentages[3])
                Nutrition(label: labels[4], amount: weights[4], percentage: percentages[4])
                Rectangle()
                    .frame(height: 0.5)
                
                
            }
            
            Group{
                Nutrition(label: labels[5], amount: weights[5], percentage: percentages[5])
                Rectangle()
                    .frame(height: 0.5)
                
                NutritionFactsDetail(label: labels[6], amount: weights[6], percentage: percentages[6])
                Rectangle()
                    .frame(height: 0.5)
                
                NutritionFactsDetail(label: labels[7], amount: weights[7], percentage: percentages[7])
                Rectangle()
                    .frame(height: 0.5)
                
                NutritionFactsDetail(label: labels[8], amount: weights[8], percentage: percentages[8], indentTwice: true)
            }
            
            
        }
        
    }
}

struct NFColumn3: View {
    
    enum NFRowError: Error {
        case labelAndWeightsMisMatch
    }
    
    let labels: [String]
    let weights: [String]
    let percentages: [Int]
    
    init(labels: [String], weights: [String], percentages: [Int]) throws {
        guard labels.count == weights.count,
              labels.count == 5 else { throw NFRowError.labelAndWeightsMisMatch }
        
        self.labels = labels
        self.weights = weights
        self.percentages = percentages
    }
    
    var body: some View {
        //column One
        VStack(alignment: .leading, spacing: 0){
            Group{
                Rectangle()
                    .frame(height: 0.5)
                
                Nutrition(label: labels[0], amount: weights[0], percentage: percentages[0])
                Rectangle()
                    .frame(height: 6)
                
                Nutrition(label: labels[1], amount: weights[1], bold: false, percentage: percentages[1])
                Rectangle()
                    .frame(height: 0.5)
                
                Nutrition(label: labels[2], amount: weights[2], bold: false , percentage: percentages[2])
                Rectangle()
                    .frame(height: 0.5)
                
                Nutrition(label: labels[3], amount: weights[3], bold: false, percentage: percentages[3])
                Rectangle()
                    .frame(height: 0.5)
                
                Nutrition(label: labels[4], amount: weights[4], bold: false, percentage: percentages[4])
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
