//
//  RecipeLinkView.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 2023-12-23.
//

import SwiftUI

struct RecipeLinkView:View {
    let imageUrl: URL?
    let title: String
    let link: String
    let time: Float
    
    @State var showWebView = false
    
    var prepTime: String{
        //if let prepTime = time {
            let hrs = Int(time / 60)
            //let mins = prepTime % 60
            let  mins = Int(time.truncatingRemainder(dividingBy: 60.0))
            switch (hrs, mins){
            case (0, 0):
                return "--:--"
                
            case (0, _):
                return "00:\(mins)"
              
            case (_, 0):
                return "\(hrs):00"
            
            case (_, _):
                return "\(hrs):\(mins)"
            
            }
        //}
       // return nil
    }
    
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                Color(red: 0, green: 0, blue: 0, opacity: 0.001)
                    .cornerRadius(10)
                    .shadow(color: Color(red: 0.2, green: 0.28, blue: 0.30, opacity: 0.3), radius: 2, x: 0, y: 0)
                    .padding(30)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    
            }
            
            VStack{
                HStack (alignment: .center){
                    VStack(alignment: .trailing){
                        Text(title)
                            .font(.system(size:40))
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .minimumScaleFactor(0.4)
                        // .lineLimit(4)
                            .if {
                                title.count < 41 ? $0.lineLimit(3) : $0.lineLimit(4)
                            }
                            .multilineTextAlignment(.trailing)
                            .textCase(.uppercase)
                        
                        Button {
                            print("Viewing")
                        } label: {
                            HStack{
                                Text("Read Full Recpie ")
                                    .bold()
                                
                                Image(systemName: "book")
                            }
                            //.shadow(color:AppColors.purple ,radius: 10)
                        }
                    }
                    Divider()
                        .frame(width: 4, height: 125)
                        .overlay(AppColors.yellow)
                    
                    VStack{
                        AsyncImage(url: imageUrl) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 125,height: 125)
                        .cornerRadius(15)
                        
                        ZStack{
                            //                        Rectangle()
                            //                            .fill(AppColors.purple)
                            //                            .frame(minWidth: 0, maxWidth: 125)
                            //                            .cornerRadius(15)
                            //                            .foregroundStyle(.white)
                            HStack{
                                Image(systemName: "clock.badge.checkmark.fill")
                                    .padding(.horizontal)
                                Text(prepTime)
                                    .bold()
                            }
                            .foregroundStyle(.white)
                            
                        }
                        //.frame(width: 100)
                    }
                    .padding(.horizontal)
                }
            }
                .foregroundColor(.primary)
                .onTapGesture {
                    print("Tapped RN")
                    showWebView = true
                }
                
        }
        .sheet(isPresented: $showWebView) {
        //                    SimpleTimer()
        //                        .frame(height: 60)
        //                        .padding(4)
            ZStack{
                RecipeWebView(url: URL(string: link)!)
                Image(systemName: "hand.tap.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(AppColors.purple)
                    .position(x: 164, y: 60)
                    .frame(width: 40)
                  
                    
            }
                //.preferredColorScheme(.dark)
        }
    }
}

struct RecipeLinkView2: View {
   // let recipe: Recipe
    let url: URL?
    let title: String
    @State private var opacity = 0.0
    
    var body: some View {
       // if let url = recipe.image {
            
            ZStack{
                if let url = url{
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                }
                //.frame(width: 125,height: 125)
                VStack{
                    Spacer()
                    Rectangle()
                        .fill(
                            LinearGradient(
                                // Defining the gradient colors and locations
                                gradient: Gradient(colors: [.black.opacity(0), .white]),
                                // Setting the start and end points for vertical gradient
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(height: 200)
                }
                
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Image(systemName: "globe")
                            .frame(height: 50)
                            .foregroundStyle(AppColors.yellow)
                        Text(title.uppercased())
                            .foregroundStyle(AppColors.yellow)
                            .font(.title)
                            .bold()
                            .padding()
                            .opacity(opacity)
                            .onAppear(perform: {
                                withAnimation(.easeOut(duration: 1)) {
                                    opacity = 1.0
                                }
                            })
                            
                        
                    }
                
                }
            }
            .cornerRadius(15)
       // }
    }
}
//
//#Preview {
//    RecipeLinkView()
//}
