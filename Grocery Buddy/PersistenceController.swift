//
//  PersistenceController.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 3/25/23.
//

import Foundation
import CoreData

struct PersistenceController{
    //singleton for whole app to access CDDB
    static let shared = PersistenceController()
    
    //CD storage
    let container: NSPersistentContainer
    
    //a test preview
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true) // wont save to disk
        
        //create 10 example values
        for _ in 0..<10{
            let cartItem = CartItem(context: controller.container.viewContext)
            cartItem.id = "food_ssdfsdfsd_sdsfs"
            cartItem.name = "rice"
        }
        
        return controller
    }()
    
    
    init(inMemory: Bool = false){
        
        //setup container
        container = NSPersistentContainer(name: "Model")
        
        // for testing
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error{
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func save(){
        //get context
        let context = container.viewContext
        
        //if context changes, try to save
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
            }
        }
    }
    
}
