//
//  HomeCell.swift
//  Iris
//
//  Created by Shalin on 7/17/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct HomeCell: View, Decodable, Hashable, Identifiable {
    
    var id:     Int
    var name:   String = ""

    var body: some View {
        ZStack(alignment: .top) {

            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    HorizontalLabel(text: "1 of 3").padding(.top, 12)
                    Image("food").retinaRectangle(width: 320, height: 400)
                    Spacer()
                }.frame(width: UIScreen.screenWidth)

                TitleView(title: "Pasta with Broccoli and Cheddar Cheese", metrics: ["99% liked", "Intermediate", "30min"])
                .frame(height: 140)
                .padding([.leading], 24)

            }.frame(width: UIScreen.screenWidth).padding([.leading], 24)
        }
        
    }
}

struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeCell(id: 0, name: "Hello")
    }
}
