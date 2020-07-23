//
//  SettingsCell.swift
//  Iris
//
//  Created by Shalin on 7/18/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct SettingsCell: View {
    var title: String
    var setting: String
    
    var body: some View {
        VStack {
            if !title.isEmpty {
                Text(title).foregroundColor(.white).retinaTypography(.h5).multilineTextAlignment(.leading).padding(.leading, 24).padding(.top, 36).frame(width: UIScreen.screenWidth, alignment: .leading)
            } else {
                Text(title).foregroundColor(.white).retinaTypography(.h5).multilineTextAlignment(.leading).padding(.leading, 24).padding(.top, 12).frame(width: UIScreen.screenWidth, alignment: .leading)
            }
            HStack {
                Text(setting).foregroundColor(.retinaBasic).retinaTypography(.p5).padding(12).multilineTextAlignment(.leading).padding(.leading, 48).padding(.top, 6).padding(.bottom, 6)
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.white).padding(.trailing, 24)
            }.background(Color.retinaFontBtn)
        }
    }
}

struct SettingsCell_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCell(title: "Food I don’t eat", setting: "Eggs")
    }
}
