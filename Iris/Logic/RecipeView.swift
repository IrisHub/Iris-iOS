//
//  RecipeView.swift
//  Iris
//
//  Created by Shalin on 7/21/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI
import SafariServices

struct RecipeView: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    // whether or not to show the Safari ViewController
    @State var showSafari = false
    // initial URL string
    @State var urlString = "https://ifoodreal.com/healthy-iced-coffee/"
    @Binding var recipePresented : Bool
    
    var body: some View {
        VStack {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    GeometryReader { geometry in
                        ZStack {
                            if geometry.frame(in: .global).minY <= 0 {
                                Image("food")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .offset(y: geometry.frame(in: .global).minY/9)
                                .clipped()
                            } else {
                                Image("food")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                                    .clipped()
                                    .offset(y: -geometry.frame(in: .global).minY)
                            }
                        }
                    }
                    .frame(height: 400)
                    
                    VStack(alignment: .leading) {
                        TitleView(title: "Chicken Avocado", metrics: ["99% liked", "Intermediate", "30min"])
                        .padding([.leading], 24)
                        
                        ListView(contents: ["1 cup day old rice", "1 egg (yolk and white separated)", "1/2 cup frozen veggies ", "1/2 tbsp ham", "1/2 tbsp of thinly sliced chinese sausage", "2 tsp shaoxing rice wine ", "2 tsp dark soy sauce (replacable with regular soy sauce)", "Pinch of white pepper"]).padding([.leading, .top, .bottom], 24)

                        
                    }
                    
                }.edgesIgnoringSafeArea(.top)
                VStack {
                    HStack {
                        retinaIconButton(image: (Image(systemName: "xmark")), action: {
//                            self.presentationMode.wrappedValue.dismiss()
                            withAnimation {
                                self.recipePresented.toggle()
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
                            self.urlString = "https://ifoodreal.com/healthy-iced-coffee/"
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

struct RecipeView_Previews: PreviewProvider {
    @State static var recipePresented : Bool = true
    static var previews: some View {
        RecipeView(recipePresented: $recipePresented)
    }
}
