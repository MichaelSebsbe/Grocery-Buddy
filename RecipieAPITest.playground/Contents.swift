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

struct Hit: Codable {
    let recipe: Recipe?
    let _links: Links?
}

struct Link: Codable {
    let href: String?
    let title: String?
}

struct Recipe: Codable {
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
    let dishType: [String?]
    let instructions: [String?]?
    let tags: [String?]?
    let externalId: String?
    let totalNutrients: [String:NutrientsInfo]?
    let totalDaily: [String:NutrientsInfo]? // percentage of each nutirent a person needs per day
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
    let foodId:  String?
}

    let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=Chicken&app_id=eef20ebb&app_key=6b37262645fc7b8c53f8e4e6e5d727d6%09")!

var request = URLRequest(url: url)

let task = URLSession.shared.dataTask(with: request) { data, response, error in
    if let error = error {
        print("Error: \(error)")
        return
    }
    guard let httpResponse = response as? HTTPURLResponse,
        (200...299).contains(httpResponse.statusCode) else {
        print("Error: Invalid HTTP response code")
        return
    }
    if let data = data {
        // Process the response data
        do{
            let result = try JSONDecoder().decode(RecipeResponse.self, from: data)
            print("sdgds")
            dump(result)
            
        }catch{
            print(error)
        }
        
    }
}

task.resume()





