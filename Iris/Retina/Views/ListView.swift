//
//  ListView.swift
//  Iris
//
//  Created by Shalin on 7/17/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct ListView: View {
    var contents: [String]
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ForEach(contents,  id: \.self) { content in
                    HStack {
                        Circle()
                        .fill(Color.retinaOverlayDark)
                        .frame(width: 10, height: 10)

                        Text(content).retinaTypography(.p5_main).foregroundColor(.retinaSnowWhite).fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            Spacer()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(contents: ["1 cup day old rice", "1 egg (yolk and white separated)", "1/2 cup frozen veggies ", "1/2 tbsp ham", "1/2 tbsp of thinly sliced chinese sausage", "2 tsp shaoxing rice wine ", "2 tsp dark soy sauce (replacable with regular soy sauce)", "Pinch of white pepper"]).environment(\.colorScheme, .dark)
    }
}

