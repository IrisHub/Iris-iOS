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
                        URLImage((URL(string: self.observed.recipes.count > 1 ? self.observed.recipes[self.selectedChoice].imageUrl : ""))!){ proxy in
                        proxy.image
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.frame(in: .global).minY <= 0 ? geometry.size.height : geometry.size.height + geometry.frame(in: .global).minY)
                            .clipped()
                        }
                        .offset(y: geometry.frame(in: .global).minY <= 0 ? geometry.frame(in: .global).minY/9 : -geometry.frame(in: .global).minY)
                    }
                    .frame(height: UIScreen.screenHeight/3)
                    
                    VStack() {
                        if self.observed.recipes.count > 1 {
                            TitleView(title: self.observed.recipes[self.selectedChoice].title, metrics: [self.observed.recipes[self.selectedChoice].rating, self.observed.recipes[self.selectedChoice].difficulty, self.observed.recipes[self.selectedChoice].cookTime])
                            .padding([.leading], 24)
                            
                            ListView(contents: self.observed.recipes[self.selectedChoice].ingredients).padding([.leading, .top, .bottom], 24)
                        }
                    }
                }
                
                VStack {
                    HStack {
                        retinaIconButton(image: (Image(systemName: "xmark")), action: {
                            withAnimation {
                                self.recipePresented = false
                            }
                        }).padding(24)
                        Spacer()
                    }.padding([.top], UIApplication.topInset)
                    Spacer()
                }
            }
            
            ZStack {
                Rectangle()
                .foregroundColor(Color.retinaOverlayDark)
                .frame(width: UIScreen.screenWidth, height: 100)
                
                HStack {
                    Spacer()
                    retinaButton(text: "Recipe Steps", style: .outlineOnly, color: .retinaPink, action: {
                        // update the URL if you'd like to
                        self.urlString = self.observed.recipes[self.selectedChoice].link
                        // tell the app that we want to show the Safari VC
                        self.showSafari = true
                    }).frame(width: (UIScreen.screenWidth-48)/2, height: 36, alignment: .trailing).padding(24)
                    .sheet(isPresented: $showSafari) {
                        SafariView(url:URL(string: self.urlString)!)
                    }
                }
            }.padding(.bottom, UIApplication.bottomInset)
            
        }.background(Color.retinaBase)
    }
}

//struct RecipeView_Previews: PreviewProvider {
//    @State static var recipePresented : Bool = true
//    static var previews: some View {
//        RecipeView(recipePresented: $recipePresented)
//    }
//}
