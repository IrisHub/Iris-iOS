//
//  DiscoveryCell.swift
//  Iris
//
//  Created by Shalin on 7/18/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI
import URLImage

struct DiscoveryCell: View {
    var title: String
    var backgroundImageUrl: String

    var body: some View {
        ZStack {
            URLImage((URL(string: backgroundImageUrl))!, delay: 0.25){ proxy in
            proxy.image
                .resizable()                     // Make image resizable
                .aspectRatio(contentMode: .fill) // Fill the frame
                .frame(width: 182, height: 182)
                .clipped()                       // Clip overlaping parts
            }
            Rectangle().frame(width: 182, height: 182).opacity(0.4)
            Text(title).frame(width: 160, height: 182).foregroundColor(.white).retinaTypography(.p5_main)
                .multilineTextAlignment(.center)
        }
    }
}

struct DiscoveryCell_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryCell(title: "Chicken", backgroundImageUrl: "food")
    }
}
