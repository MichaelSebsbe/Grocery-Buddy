//
//  RecipeDetails.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 1/3/23.
//

import SwiftUI

struct RecipeDetails: View {
    var body: some View {
        ZStack(alignment: .leading) {
            Color(red: 1, green: 0.8, blue: 0.2)
                //.ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.size.width - 30, height: UIScreen.main.bounds.size.height - 50)
                .shadow(radius: 0)
                .cornerRadius(40)
            .shadow(radius: 3)
            
            VStack {
                Image("cheese")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                    .cornerRadius(30)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                    .shadow(radius: 3)
                Spacer()
            }
        }
    }
}

struct RecipeDetails_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetails().previewDevice(PreviewDevice(rawValue: "iPhone 13"))
    }
}
