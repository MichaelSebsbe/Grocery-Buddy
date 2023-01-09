//
//  RequestManager.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 1/5/23.
//

import Foundation

class RequestManager{
    
   
    static func getRecpies(for searchTerm: String, completion: @escaping(RecipeResponse?) -> Void ) {
        
        let apiKey = "6b37262645fc7b8c53f8e4e6e5d727d6%09"
        let appID = "eef20ebb"
        
        let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=\(searchTerm)&app_id=\(appID)&app_key=\(apiKey)")!
        let request = URLRequest(url: url)
        
        //var recipes: RecipeResponse?
        
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
                    let results = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    completion(results)
                    
                }catch{
                    print(error)
                    completion(nil)
                }
                
            }
        }

        task.resume()
    }
}
