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
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .retinaTypography(.h4_secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.retinaSnowWhite)
                    .padding(.bottom, -12)
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.retinaWinterGrey)
                        .retinaTypography(.p6_main)
                    Text(metrics.joined(separator: "  •  "))
                        .retinaTypography(.p6_main)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.retinaWinterGrey)
                }
            }
            Spacer()
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Chicken Avocado Toast", metrics: ["99% liked", "Intermediate", "30min"])
    }
}
