//
//  RequestManager.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 1/5/23.
//

import Foundation
import SwiftUI

class RequestManager{
    

    static func getRecpies(for searchTerm: String, completion: @escaping(RecipeResponse?) -> Void ) {
        
        let urlSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let apiKey = ProcessInfo.processInfo.environment["EDAMAM_API_KEY"]!;
        let appID = ProcessInfo.processInfo.environment["EDAMAM_APP_ID"]!;
        
        let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=\(urlSearchTerm)&app_id=\(appID)&app_key=\(apiKey)")!
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
    
    
    static func loadImageFrom(_ url: String ) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    
                }
            }
        }.resume()
    }
}
