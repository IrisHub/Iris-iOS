//
//  SearchCell.swift
//  Iris
//
//  Created by Shalin on 7/21/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct SearchCell: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title).foregroundColor(.retinaSnowWhite).retinaTypography(.h5_main).fixedSize(horizontal: false, vertical: true).padding(.leading, 24).padding(.top, 12)
                Text(subtitle).foregroundColor(.retinaWinterGrey).retinaTypography(.p6_main).fixedSize(horizontal: false, vertical: true).padding(.leading, 24).padding(.top, 6).padding(.bottom, 12)
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(.white).padding(.trailing, 24)
        }.background(Color.black)
    }
}

struct SearchCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchCell(title: "Chicken", subtitle: "Ingredient")
    }
}
