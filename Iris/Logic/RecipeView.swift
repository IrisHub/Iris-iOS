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
    // whether or not to show the Safari ViewController
    @State var showSafari = false
    // initial URL string
    @State var urlString = "https://ifoodreal.com/healthy-iced-coffee/"

    
    var body: some View {
        VStack {
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
                        VStack {
                            HStack {
                                retinaIconButton(image: (Image(systemName: "chevron.left")), action: {  }).padding(24)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                }
                .frame(height: 400)
                
                VStack(alignment: .leading) {
                    TitleView(title: "Chicken Avocado Toast", metrics: ["99% liked", "Intermediate", "30min"])
                    .padding([.leading], 24)
                    .frame(height: 140)

                    ListView(title: "Ingredients", contents: ["1 cup day old rice", "1 egg (yolk and white separated)", "1/2 cup frozen veggies ", "1/2 tbsp ham", "1/2 tbsp of thinly sliced chinese sausage", "2 tsp shaoxing rice wine ", "2 tsp dark soy sauce (replacable with regular soy sauce)", "Pinch of white pepper"]).padding([.leading, .top], 24)
                }
                
            }.edgesIgnoringSafeArea(.top)
            Group {
                ZStack {
                    Rectangle()
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(width: UIScreen.screenWidth, height: 90)
                    
                    HStack {
                        Spacer()
                        retinaButton(text: "See Recipe Steps", style: .outline, color: .pink, action: {
                            // update the URL if you'd like to
                            self.urlString = "https://ifoodreal.com/healthy-iced-coffee/"
                            // tell the app that we want to show the Safari VC
                            self.showSafari = true
                        }).frame(width: 180, height: 36, alignment: .trailing).padding(24)
                        .sheet(isPresented: $showSafari) {
                            SafariView(url:URL(string: self.urlString)!)
                        }
                    }
                }
            }
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}


let articleContent =

"""
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
At vero eos et accusam et justo duo dolores et ea rebum.
Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
"""
