//
//  ContentView.swift
//  Iris
//
//  Created by Shalin on 7/16/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .frame(width: 300, height: 500)
                .foregroundColor(.retinaBackground)
            VStack(alignment: .leading) {
                Image("food")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 300)
                    .clipped()

                Text("By Ingredient")
                    .retinaTypography(.h4)
                    .padding([.top, .leading])
                    .foregroundColor(.retinaBasic)
                
                Divider().frame(width: 300)
                
                Text("Your Shortcuts").retinaTypography(.p6)                    .padding(.leading)

                
                Button(action: {}) {
                    Text("Pasta")
                }.padding([.top, .leading])
                
                Button(action: {}) {
                    Text("Salmon")
                }.padding(.leading)
                Button(action: {}) {
                    Text("Avocado")
                }.padding(.leading)
                Button(action: {}) {
                    Text("Shrimp")
                }.padding(.leading)


            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.colorScheme, .dark)
    }
}
