//
//  Typography.swift
//  Iris
//
//  Created by Shalin on 7/16/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI


public struct RetinaTypography: ViewModifier {
    
    private enum Family: String {
        case
        main = "HelveticaNeue",
        secondary = "Georgia"
    }
    
    private enum Weight: String {
        case regular, medium, light, heavy, bold, semibold, black
    }
    
    private enum Size: CGFloat {
        case
        one = 60,
        two = 48,
        three = 36,
        four = 24,
        five = 16,
        six = 14
    }
    
    enum Style {
        
        /// Titles
        case h1, h2, h3, h4, h5, h6
        
        /// Subtitles
        case s1, s2
        
        /// Paragraphs
        case p5, p6
        
        /// Captions
        case c1, c2
    }
        
    var style: Style
    
    private func getName(_ family: Family, _ weight: Weight) -> String {
        let fontWeight = weight.rawValue
        let familyName = family.rawValue

        return "\(familyName)-\(fontWeight)"
    }
    
    private func customFont(family: Family, weight: Weight, size: Size) -> Font {
        return Font.custom(getName(family, weight), size: size.rawValue)
    }
    
    public func body(content: Content) -> some View {
        switch style {
        case .h1: return content
            .font(customFont(family: .secondary, weight: .bold, size: .one))
        case .h2: return content
            .font(customFont(family: .main, weight: .bold, size: .two))
        case .h3: return content
            .font(customFont(family: .main, weight: .bold, size: .three))
        case .h4: return content
            .font(customFont(family: .main, weight: .bold, size: .four))
        case .h5: return content
            .font(customFont(family: .main, weight: .bold, size: .five))
        case .h6: return content
            .font(customFont(family: .main, weight: .bold, size: .six))

        case .s1: return content
            .font(.system(size: 15, weight: .semibold))
        case .s2: return content
            .font(.system(size: 13, weight: .semibold))
            
        case .p5: return content
            .font(customFont(family: .main, weight: .regular, size: .five))
        case .p6: return content
            .font(customFont(family: .main, weight: .regular, size: .six))

        case .c1: return content
            .font(.system(size: 12, weight: .regular))
        case .c2: return content
            .font(.system(size: 12, weight: .bold))
        }
    }
}

extension View {
    func retinaTypography(_ style: RetinaTypography.Style) -> some View {
        self
            .modifier(RetinaTypography(style: style))
    }
    
    func retinaTypography(_ style: RetinaTypography.Style, color: Color) -> some View {
        self
            .modifier(RetinaTypography(style: style))
            .foregroundColor(color)
    }
}


struct Typography_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    Text("Text").retinaTypography(.h1, color: .retinaPrimary)
                    Text("Text").retinaTypography(.h1, color: .retinaSuccess)
                    Text("Text").retinaTypography(.h1, color: .retinaDanger)
                
                    Text("Text").retinaTypography(.h1)
                    Text("Text").retinaTypography(.h2)
                    Text("Text").retinaTypography(.h3)
                    Text("Text").retinaTypography(.h4)
                    Text("Text").retinaTypography(.h5)
                    Text("Text").retinaTypography(.h6)
                }
                Group {
    //                Text("Text").retinaTypography(.s1)
    //                Text("Text").retinaTypography(.s2)
                    
                    Text("Text").retinaTypography(.p5)
                    Text("Text").retinaTypography(.p6)
                    
    //                Text("Text").retinaTypography(.c1)
    //                Text("Text").retinaTypography(.c2)
                }
            }.padding()
            Spacer()
        }
    }
}
