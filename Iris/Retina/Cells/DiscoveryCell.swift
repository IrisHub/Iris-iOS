//
//  DiscoveryCell.swift
//  Iris
//
//  Created by Shalin on 7/18/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct DiscoveryCell: View {
    var title: String
    var backgroundImageUrl: String

    var body: some View {
        ZStack {
            Image(backgroundImageUrl).retinaRectangle(width: 160, height: 100)
            Rectangle().frame(width: 160, height: 100).opacity(0.6)
            Text(title).foregroundColor(.white).retinaTypography(.p5)
        }
    }
}

struct DiscoveryCell_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryCell(title: "Chicken", backgroundImageUrl: "food")
    }
}
