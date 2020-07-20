//
//  HomeCell.swift
//  Iris
//
//  Created by Shalin on 7/17/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct HomeCell: View {
    
    var card: Card
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .frame(width: 300, height: 500)
                .foregroundColor(.retinaBackground).padding()
            VStack(alignment: .leading) {
                
                Image("food")
                    .retinaRectangle(width: 300, height: 300)


                Text(card.title)
                    .retinaTypography(.h4)
                    .padding([.top, .leading])
                    .foregroundColor(.retinaBasic)
                
                Divider().frame(width: 300)
                
                Text("Your Shortcuts").retinaTypography(.p6)                    .padding(.leading)

                VStack(alignment: .leading) {
                    ForEach(card.shortcuts, id: \.self) { shortcut in
                        Button(action: {}) {
                            Text(shortcut)
                        }.padding([.top,.leading])
                    }
                }
            }
        }
        
    }
}

struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeCell(card: Card(title: "By ingredient", shortcuts: ["Pasta", "Salmon", "Avocado", "Shrimp"])).environment(\.colorScheme, .dark)
    }
}
