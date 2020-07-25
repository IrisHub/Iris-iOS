//
//  Palette.swift
//  Iris
//
//  Created by Shalin on 7/16/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

extension Color {
    
    static let retinaOverflow = Color("overflow")
    static let retinaBase = Color("base")
    static let retinaSurface = Color("surface")
    static let retinaOverlayLight = Color("overlay_light")
    static let retinaOverlayDark = Color("overlay_dark")
    static let retinaWinterGrey = Color("winter_grey")
    static let retinaSnowWhite = Color("snow_white")
    
    static let retinaPink = Color(red: 248.0 / 255.0, green: 61.0 / 255.0, blue: 123.0 / 255.0)
    static let retinaPurple = Color(red: 189.0 / 255.0, green: 63.0 / 255.0, blue: 187.0 / 255.0)
}

struct Color_Previews: PreviewProvider {

    static var previews: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack{
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(.retinaOverflow)
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(.retinaBase)
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(.retinaSurface)
                Rectangle().size(CGSize(width: 50, height: 50))
                .foregroundColor(.retinaOverlayLight)
                Rectangle().size(CGSize(width: 50, height: 50))
                .foregroundColor(.retinaOverlayDark)
                Rectangle().size(CGSize(width: 50, height: 50))
                .foregroundColor(.retinaWinterGrey)
                Rectangle().size(CGSize(width: 50, height: 50))
                .foregroundColor(.retinaSnowWhite)
            }
        }
    .padding()
    }
}
