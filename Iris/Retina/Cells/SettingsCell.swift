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
                Text(title).foregroundColor(.retinaSnowWhite).retinaTypography(.h5_main).fixedSize(horizontal: false, vertical: true).padding(.leading, 24).padding(.top, 36).frame(width: UIScreen.screenWidth, alignment: .leading)
            } else {
                Text(title).foregroundColor(.retinaSnowWhite).retinaTypography(.h5_main).fixedSize(horizontal: false, vertical: true).padding(.leading, 24).padding(.top, 12).frame(width: UIScreen.screenWidth, alignment: .leading)
            }
            HStack {
                Text(setting).foregroundColor(.retinaWinterGrey).retinaTypography(.p5_main).fixedSize(horizontal: false, vertical: true).padding(.leading, 24).padding(.top, 18).padding(.bottom, 18)
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.retinaWinterGrey).padding(.trailing, 24)
            }.background(Color.retinaOverlayDark)
        }
    }
}

struct SettingsCell_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCell(title: "Food I don’t eat", setting: "Eggs")
    }
}
