//
//  HomeCell.swift
//  Iris
//
//  Created by Shalin on 7/17/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct HomeCell<Content: View>: View {
    var id:     Int
    var name:   String = ""
    var commitDestination: Content

    var body: some View {
        ZStack(alignment: .top) {

            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    HorizontalLabel(text: "1 of 3").padding(.top, 12)
                    NavigationLink(destination: self.commitDestination) {
                        Image("food").retinaRectangle(width: 320, height: 400)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                }.frame(width: UIScreen.screenWidth)

                NavigationLink(destination: self.commitDestination) {
                    TitleView(title: "Pasta with Broccoli and Cheddar Cheese", metrics: ["99% liked", "Intermediate", "30min"])
                }
                .buttonStyle(PlainButtonStyle())
                .frame(height: 140)
                .padding([.leading], 24)

            }.frame(width: UIScreen.screenWidth).padding([.leading], 24)
        }
    }
}

struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeCell(id: 0, name: "Hello", commitDestination: RecipeView())
    }
}
