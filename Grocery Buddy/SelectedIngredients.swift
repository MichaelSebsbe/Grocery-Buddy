//
//  SelectedIngredients.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 8/17/23.

/*
 This clss will hold users selected ingredients and publish changes for all views
 */

import Foundation
import Combine

class SelectedIngredients: ObservableObject{
    @Published var ingredients = [String: [String: Ingredient]]() //category: [foodid: IngObj]
    
    enum SelectedIngredintsError: Error{
        case IngredientAppendError
    }
    
    public func append(_ ingredient: Ingredient){
        guard let foodId = ingredient.foodId,
              let category = ingredient.foodCategory?.capitalized
        else {
            print("Error unwrapping ingredeints")
            return
        }
        
        if let _ = ingredients[category]{ //category exists
            if ingredients[category]![foodId] == nil {
                ingredients[category]![foodId] = ingredient
                
            }else{ //if exists, add measure
                guard let quantityA = ingredients[category]?[foodId]?.quantity,
                let quantityB = ingredient.quantity else {
                    print("Error unwrapping ingredeints")
                    return
                }
                let totalQuantity = quantityA + quantityB
                
                ingredients[category]![foodId] = Ingredient(text: ingredient.text, quantity: totalQuantity, measure: ingredient.measure, food: ingredient.food, weight: ingredient.weight, foodCategory: ingredient.foodCategory, foodId: ingredient.foodId, image: ingredient.image)
            }
        } else {
            ingredients[category] = [String: Ingredient]()
            ingredients[category]![foodId] = ingredient
        }
        
    }
    //add core data logic here to store to database
}
