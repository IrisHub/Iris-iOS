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
                    HorizontalLabel(text: "1 of " + String(id+1)).padding(.top, 12)
                    Button(action: {
                        withAnimation {
                            self.selectedChoice = self.id
                            self.recipePresented.toggle()
                        }
                    }) {
//                        Image(recipe.imageUrl).retinaRectangle(width: 320, height: 420)
                        
                        URLImage((URL(string: recipe.imageUrl))!){ proxy in
                        proxy.image
                            .resizable()                     // Make image resizable
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill) // Fill the frame
                            .frame(width: 320, height: 420)
                            .clipped()                       // Clip overlaping parts
                            
                        }
                    }
                    
                    Spacer()
                }.frame(width: UIScreen.screenWidth)

                Button(action: {
                    withAnimation {
                        self.recipePresented.toggle()
                    }
                }) {
                    TitleView(title: recipe.title, metrics: [recipe.rating, recipe.difficulty, recipe.cookTime])
                }

                .frame(height: 140)
                .padding([.leading], 24)

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
