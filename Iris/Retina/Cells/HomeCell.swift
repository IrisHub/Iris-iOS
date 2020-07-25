//
//  HomeCell.swift
//  Iris
//
//  Created by Shalin on 7/17/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct HomeCell: View {
    var id:     Int
    var name:   String = ""
//    var commitDestination: Content
    @Binding var recipePresented : Bool

    var body: some View {
        ZStack(alignment: .top) {

            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    HorizontalLabel(text: "1 of 3").padding(.top, 12)
                    Button(action: {
                        withAnimation {
                            self.recipePresented.toggle()
                        }
                    }) {
                        Image("food").retinaRectangle(width: 320, height: 420)
                    }
//                    NavigationLink(destination: self.commitDestination) {
//                    }
                    
                    Spacer()
                }.frame(width: UIScreen.screenWidth)

                Button(action: {
                    withAnimation {
                        self.recipePresented.toggle()
                    }
                }) {
                    TitleView(title: "Pasta with Broccoli and Cheddar Cheese", metrics: ["99% liked", "Intermediate", "30min"])
                }

//                NavigationLink(destination: self.commitDestination) {
//                }
                .frame(height: 140)
                .padding([.leading], 24)

            }.frame(width: UIScreen.screenWidth).padding([.leading], 24)
        }
    }
}

struct HomeCell_Previews: PreviewProvider {
    @State static var recipePresented: Bool = false
    static var previews: some View {
        HomeCell(id: 0, name: "Hello", recipePresented: $recipePresented)
    }
}
