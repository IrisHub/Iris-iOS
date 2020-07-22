//
//  ListView.swift
//  Iris
//
//  Created by Shalin on 7/17/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    var title: String
    var contents: [String]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(title).retinaTypography(.h3).foregroundColor(.black)
            
            ForEach(contents,  id: \.self) { content in
                VStack {
                    HStack {
                        Circle()
                        .fill(Color.retinaSuccess)
                        .frame(width: 15, height: 15)

                        Text(content).retinaTypography(.p5).foregroundColor(.black).multilineTextAlignment(.leading)
                    }
                }.padding(.top)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(title: "Ingredients", contents: ["1 cup day old rice", "1 egg (yolk and white separated)", "1/2 cup frozen veggies ", "1/2 tbsp ham", "1/2 tbsp of thinly sliced chinese sausage", "2 tsp shaoxing rice wine ", "2 tsp dark soy sauce (replacable with regular soy sauce)", "Pinch of white pepper"]).environment(\.colorScheme, .dark)
    }
}

