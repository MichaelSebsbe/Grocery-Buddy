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
    @Published var ingredients = [String: Ingredient]()
    
    //add core data logic here to store to database
}
