//
//  RecipeView.swift
//  Iris
//
//  Created by Shalin on 7/21/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI
import SafariServices
import URLImage

struct RecipeView: View {
    // whether or not to show the Safari ViewController
    @ObservedObject var observed: TopChoicesObserver
    var selectedChoice: Int = 0

    @State var showSafari = false
    // initial URL string
    @State var urlString = "https://ifoodreal.com/healthy-iced-coffee/"
    @State var imageURL = "None"
    @Binding var recipePresented : Bool
    
    var body: some View {
        VStack {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    GeometryReader { geometry in
                        ZStack {
                            if self.observed.recipes.count > 1 {
                                if geometry.frame(in: .global).minY <= 0 {
                                    URLImage((URL(string: self.observed.recipes[self.selectedChoice].imageUrl))!){ proxy in
                                    proxy.image
                                        .resizable()                     // Make image resizable
                                        .renderingMode(.original)

                                        .aspectRatio(contentMode: .fill) // Fill the frame
                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                        .clipped()                       // Clip overlaping parts
                                    }
                                    .offset(y: geometry.frame(in: .global).minY/9)
                                } else {
                                    URLImage((URL(string: self.observed.recipes[self.selectedChoice].imageUrl))!){ proxy in
                                    proxy.image
                                        .resizable()                     // Make image resizable
                                        .renderingMode(.original)
                                        .aspectRatio(contentMode: .fill) // Fill the frame
                                        .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                                        .clipped()                       // Clip overlaping parts
                                    }
                                    .offset(y: -geometry.frame(in: .global).minY)

                                }
                            }
                        }
                    }
                    .frame(height: 400)
                    
                    VStack(alignment: .leading) {
                        if self.observed.recipes.count > 1 {
                            TitleView(title: self.observed.recipes[self.selectedChoice].title, metrics: [self.observed.recipes[self.selectedChoice].rating, self.observed.recipes[self.selectedChoice].difficulty, self.observed.recipes[self.selectedChoice].cookTime])
                            .padding([.leading], 24)
                            
                            ListView(contents: self.observed.recipes[self.selectedChoice].ingredients).padding([.leading, .top, .bottom], 24)
                        }
                    }
                    
                }.edgesIgnoringSafeArea(.top)
                VStack {
                    HStack {
                        retinaIconButton(image: (Image(systemName: "xmark")), action: {
                            withAnimation {
                                self.recipePresented = false
                            }
                        }).padding(24)
                        Spacer()
                    }
                    Spacer()
                }.edgesIgnoringSafeArea(.top).padding([.top], 24)
            }
            
            Group {
                ZStack {
                    Rectangle()
                    .foregroundColor(Color.retinaOverlayDark)
                    .frame(width: UIScreen.screenWidth, height: 120)
                    .edgesIgnoringSafeArea(.bottom)
                    
                    HStack {
                        Spacer()
                        retinaButton(text: "See Recipe Steps", style: .outlineOnly, color: .retinaPink, action: {
                            // update the URL if you'd like to
                            self.urlString = self.observed.recipes[self.selectedChoice].link
                            // tell the app that we want to show the Safari VC
                            self.showSafari = true
                        }).frame(width: 180, height: 36, alignment: .trailing).padding(24).padding(.bottom,12)
                        .sheet(isPresented: $showSafari) {
                            SafariView(url:URL(string: self.urlString)!)
                        }
                    }
                }
            }
        }.background(Color.retinaBase)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .padding([.bottom], 24)
    }
}

//struct RecipeView_Previews: PreviewProvider {
//    @State static var recipePresented : Bool = true
//    static var previews: some View {
//        RecipeView(recipePresented: $recipePresented)
//    }
//}
