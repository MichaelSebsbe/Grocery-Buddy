//
//  RecipeResponse.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 1/5/23.
//

import Foundation

struct RecipeResponse: Codable{
    let count: Int?
    let from: Int? //this returns count starts from
    let to: Int? //and ends
    let _links: Links?
    let hits: [Hit?]
}

struct Links: Codable{
    //let self: Link
    //let next: Link
}

struct Hit: Codable{
    let recipe: Recipe?
    let _links: Links?
}

struct Link: Codable {
    let href: String?
    let title: String?
}

struct Recipe: Codable{
    
    let uri: String?
    let label: String? //title of recipe
    let image: String?
    let images: [String: ImageInfo]
    let source: String? //author
    let url: String? //author url
    let shareAs: String?
    let yield: Float?
    let dietLabels: [String?]
    let healthLabels: [String]?
    let cautions: [String?]
    let ingredientLines: [String?]
    let ingredients: [Ingredient]
    let calories: Float?
    //let glycemicIndex: Float?
    //let totalCO2Emissions: Float?
    //let co2EmissionsClass: String?
    let totalWeight: Float?
    let cuisineType: [String]?
    let mealType: [String?]
    let dishType: [String]?
    let instructions: [String?]?
    let tags: [String?]?
    let externalId: String?
    let totalNutrients: [String:NutrientsInfo]?
    let totalDaily: [String:NutrientsInfo]? // percentage of each nutirent a person needs per day
    let totalTime: Int?
    //let digest: Digest
}
   
enum FoodPics: Codable {
    case THUMBNAIL(ImageInfo?)
    case SMALL(ImageInfo?)
    case REGULAR(ImageInfo?)
    case LARGE(ImageInfo?)
}
     
struct ImageInfo: Codable{
    let url: String?
    let width: Int?
    let height: Int?
}

struct NutrientsInfo: Codable{
    let label: String?
    let quantity: Float?
    let unit: String?
}

struct Ingredient: Codable {
    let text: String?
    let quantity: Float?
    let measure: String?
    let food: String?
    let weight: Float?
    let foodCategory: String?
    let foodId:  String?
    let image: String?///url of the image
}

