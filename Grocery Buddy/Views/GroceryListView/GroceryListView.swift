//
//  ContentView.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 12/21/22.
//

import SwiftUI

struct GroceryListView: View {
    @State private var items: [Grocery] = []
    @State private var showAddItemView: Bool = false
    @State private var newItemText: String = ""
    @State private var newItemDescription: String = ""
    @State private var isFound: Bool = false
    
    var body: some View {
        //to show logged in users
        
        
        VStack{
            Buddies()
            
            NavigationView {
                
                List {
                    ForEach(items, id: \.self) { item in
                        HStack{
                            Text(item.name)
                            Text(item.description)
                                .fontWeight(.ultraLight)
                            
                            Spacer()
                            Toggle("", isOn: Binding(get: {
                                item.isFound
                            }, set: { newValue in
                                item.isFound = newValue
                            }))
                            .tint(.orange)
                            
                        }
                    }
                    .onDelete { indexSet in
                        items.remove(atOffsets: indexSet)
                    }
                }
                .navigationBarItems(trailing: Button(action: {
                    self.showAddItemView = true
                }) {
                    Image(systemName: "plus")
                })
                .alert("Add a Grocery Item", isPresented: $showAddItemView, actions: {
                    VStack{
                        TextField("Milk 🐮", text: $newItemText)
                        TextField("2%", text: $newItemDescription)
                        Button {
                            let grocery = Grocery(name: self.newItemText, description: self.newItemDescription)
                            self.items.append(grocery)
                            self.newItemText = ""
                            self.newItemDescription = ""
                            self.showAddItemView = false
                        } label: {
                            Text("Add")
                        }
                        
                    }
                })
                
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView()
    }
}


// this will be used to show friends
struct Buddies: View{
    
    var body: some View {
        //to show logged in users
        HStack{
            VStack{
                Image(systemName: "person.crop.circle")
                Text("Mike")
            }
            VStack{
                Image(systemName: "person.crop.circle")
                Text("Fev")
            }
            VStack{
                Image(systemName: "person.crop.circle")
                Text("Yab")
            }
        }
    }
}

