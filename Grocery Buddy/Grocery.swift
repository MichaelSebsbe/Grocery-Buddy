//
//  Grocery.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 12/22/22.
//

import Foundation

class Grocery: Hashable, ObservableObject{
    let name: String
    let description: String
    @Published var isFound = false
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    static func == (lhs: Grocery, rhs: Grocery) -> Bool {
        return lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
}
