//
//  ImageText.swift
//  Iris
//
//  Created by Shalin on 7/19/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct IconText: View {
    var text: String
    var icon: String
    var iconColor: Color
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(iconColor)

            Text(text)
                .retinaTypography(.p6)
                .padding(.leading, 2)
        }
    }
}

struct IconText_Previews: PreviewProvider {
    static var previews: some View {
        IconText(text: "For you", icon: "checkmark", iconColor: .retinaBasic)
    }
}
