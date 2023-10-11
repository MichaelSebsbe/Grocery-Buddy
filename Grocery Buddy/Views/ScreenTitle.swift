//
//  ScreenTitleView.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 2023-10-08.
//

import SwiftUI


struct ScreenTitle: View {
    
    let title: String
    let imageSystemName: String
    var color: Color
    
    init(title: String, imageSystemName: String, screenColor: ScreenTheme){
        self.title = title
        self.imageSystemName = imageSystemName

        switch screenColor{
            case .green:
                color = AppColors.mint
            case .red:
                color = AppColors.red
            case .yellow:
                color = AppColors.yellow
        }
        
    }
    
    var body: some View {
        Label {
            Text(title)
        } icon: {
            Image(systemName: imageSystemName)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, color)
        }
        .font(.headline)
    }
}

struct ScreenTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenTitle(title: "Today's Featured Recipies", imageSystemName: "cart.circle.fill", screenColor: .green)
    }
}
