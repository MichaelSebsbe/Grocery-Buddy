//
//  GroceryItems.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 8/21/23.
//

import SwiftUI

struct GroceryItemsView: View {
    var body: some View {
        ScrollView{
            GroceryView()
            GroceryView()
            HStack {Text("Condiments and Spices")
                    .font(.footnote)
                    
                Spacer()}
            .padding(.leading)
            GroceryView()
            GroceryView()
            GroceryView()
        }
    }
}

struct GroceryItems_Previews: PreviewProvider {
    static var previews: some View {
        GroceryItemsView()
    }
}


struct GroceryView: View {
    @State var isFound = false
   // let name: String
    //let amount:
    
    var body: some View{
        ZStack {
            Rectangle()
                .foregroundColor(.yellow)
                .frame(height: 75)
                .cornerRadius(10)
            
            HStack{
                Image("cheese")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                Text("Mozzerella Cheese")
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("|")
                    .foregroundColor(.white)
                
                Text("300 grams ")
            }
            .padding(5)
            
            if(isFound){
                Rectangle()
                    .frame(height: 1)
                    .padding(EdgeInsets(top: 0, leading: 80, bottom: 0, trailing: 10))
                
            }
        }
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
        .if(isFound){
            $0.opacity(0.2)
        }
        .onTapGesture {
            withAnimation(.easeIn(duration: 0.5)){
                isFound.toggle()
            }
        }
    }
}
