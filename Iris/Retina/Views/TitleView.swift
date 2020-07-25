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
                .retinaTypography(.h4_secondary)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.retinaSnowWhite)
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.retinaWinterGrey)
                Text(metrics.joined(separator: "  •  "))
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.retinaWinterGrey)
            }
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Chicken Avocado Toast", metrics: ["99% liked", "Intermediate", "30min"])
    }
}
