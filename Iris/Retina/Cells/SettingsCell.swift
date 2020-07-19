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
        Button(action: {
            
        }) {
            ZStack(alignment: .leading) {
                Rectangle().frame(width: UIScreen.screenWidth, height: 72).foregroundColor(.retinaFontBtn)
                HStack {
                    Text(title).foregroundColor(.retinaBackground).retinaTypography(.h5).padding(24).multilineTextAlignment(.leading).frame(width: 204, alignment: .leading)
                    Text(setting).foregroundColor(.retinaBasic).retinaTypography(.p5).padding(12).multilineTextAlignment(.leading).frame(width: 168, alignment: .trailing)
                    Image(systemName: "chevron.right").foregroundColor(.retinaBackground)
                }
            }
        }
    }
}

struct SettingsCell_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCell(title: "Food I don’t eat", setting: "Eggs")
    }
}
