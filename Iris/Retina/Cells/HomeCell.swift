//
//  HomeCell.swift
//  Iris
//
//  Created by Shalin on 7/17/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI
import URLImage

struct HomeCell: View {
    var id:     Int
    var recipe:   Recipe
    @Binding var recipePresented : Bool
    @Binding var selectedChoice: Int

    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    HorizontalLabel(text: String(id+1) + " of 3").padding(.top, 12)
                    Button(action: {
                        withAnimation {
                            self.selectedChoice = self.id
                            self.recipePresented = true
                        }
                    }) {

                        URLImage((URL(string: recipe.imageUrl))!){ proxy in
                        proxy.image
                            .resizable()                     // Make image resizable
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill) // Fill the frame
                            .frame(width: UIScreen.screenWidth * 0.75, height: (UIScreen.screenWidth * 0.75 * 4) / 3)
                            .clipped()                       // Clip overlaping parts
                        }
                    }
                    
                    Spacer()
                }

                Button(action: {
                    withAnimation {
                        self.recipePresented = true
                    }
                }) {
                    TitleView(title: recipe.title, metrics: [recipe.rating, recipe.difficulty, recipe.cookTime])
                }
                .padding(.leading, 12).padding(.trailing, 24)

            }.frame(width: UIScreen.screenWidth).padding([.leading], 24)
        }
    }
}

//struct HomeCell_Previews: PreviewProvider {
//    @State static var recipePresented: Bool = false
//    static var previews: some View {
//        HomeCell(id: 0, name: "Hello", recipePresented: $recipePresented)
//    }
//}
