//
//  Palette.swift
//  Iris
//
//  Created by Shalin on 7/16/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

extension Color {
    
    // MARK: Basic Colors
    
    static let retinaBackground = Color("background")
    static let retinaBasic = Color("basic")
    static let retinaPrimary = Color("primary")
    
    // MARK: Font Colors
    
    /// Standard Font Color
    static let retinaFontStd = Color("font_std")
    /// Hint Font Color
    static let retinaFontHint = Color("font_hint")
    /// Disabled Font Color
    static let retinaFontDisabled = Color("font_disabled")
    /// Button Font Color
    static let retinaFontBtn = Color("font_button")
    
    // MARK: Semantic Colors
    
    static let retinaDanger = Color("danger")
    static let retinaInfo = Color("info")
    static let retinaSuccess = Color("success")
    static let retinaWarning = Color("warning")
    
    // MARK: State Colors
    
    /// Active State Color - Primary Style
    static let retinaActivePrimary = Color("activePrimary")
    /// Active State Color - Basic Style
    static let retinaActiveBasic = Color("activeBasic")
    
    static let retinaPink = Color(red: 248.0 / 255.0, green: 61.0 / 255.0, blue: 123.0 / 255.0)
    static let retinaPurple = Color(red: 189.0 / 255.0, green: 63.0 / 255.0, blue: 187.0 / 255.0)
    static let retinaGradient = LinearGradient(gradient: Gradient(colors: [.retinaPink, .retinaPurple]), startPoint: .top, endPoint: .bottom)

}

struct Color_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack{
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(.retinaBasic)
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(.retinaPrimary)
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(.retinaSuccess)
                Rectangle().size(CGSize(width: 50, height: 50))
                .foregroundColor(.retinaInfo)
                Rectangle().size(CGSize(width: 50, height: 50))
                .foregroundColor(.retinaWarning)
                Rectangle().size(CGSize(width: 50, height: 50))
                .foregroundColor(.retinaDanger)
            }
            Text("Hello, World!")
                .foregroundColor(.retinaActivePrimary)
                .background(Color.retinaActiveBasic)
                .environment(\.colorScheme, .dark)
        }
    .padding()
    }
}
