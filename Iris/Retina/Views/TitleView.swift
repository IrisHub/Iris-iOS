//
//  TitleView.swift
//  Iris
//
//  Created by Shalin on 7/18/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    var title: String
    var metrics: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .retinaTypography(.h3)
                .multilineTextAlignment(.leading)
                .padding(.leading, 24)
            HStack {
                Image(systemName: "star.fill").foregroundColor(.retinaInfo)
                Text(metrics.joined(separator: "  •  "))
                    .retinaTypography(.p5)
                    .multilineTextAlignment(.leading)
            }.padding(.leading, 24)
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Chicken Avocado Toast", metrics: ["99% liked", "Intermediate", "30min"])
    }
}
