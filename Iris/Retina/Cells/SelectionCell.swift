//
//  SelectionCell.swift
//  Iris
//
//  Created by Shalin on 7/18/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct SelectionCell: View {
    var title: String
    @Binding var selectedTitles: [String]
    var isSingleSelect: Bool

    var body: some View {
        Button(action: {
            if !self.isSingleSelect {
                if (!self.selectedTitles.contains(where: {$0.caseInsensitiveCompare(self.title) == .orderedSame})) {
                    self.selectedTitles.append(self.title.capitalizingFirstLetter())
                } else {
                    self.selectedTitles.removeAll { $0.lowercased() == self.title.lowercased() }
                }
            } else {
                self.selectedTitles.removeAll()
                self.selectedTitles.append(self.title.capitalizingFirstLetter())
            }
        }) {
            ZStack(alignment: .leading) {
                Rectangle().frame(width: UIScreen.screenWidth, height: 72).foregroundColor(.retinaBase)
                HStack {
                    Circle()
                        .fill(self.selectedTitles.contains(where: {$0.caseInsensitiveCompare(self.title) == .orderedSame}) ? Color.white : Color.retinaBase)
                        .frame(width: 8, height: 8)
                        .padding(.leading, 24)
                    
                    Text(title.capitalizingFirstLetter()).foregroundColor(.white).retinaTypography(.h5_main).fixedSize(horizontal: false, vertical: true).frame(width: 204, alignment: .leading).padding(.leading, 12)
                }
            }
        }
    }
}

struct SelectionCell_Previews: PreviewProvider {
    @State static var selected = ["Vegetarian", "Vegan"]
    static var previews: some View {
        SelectionCell(title: "Vegetarian", selectedTitles: $selected, isSingleSelect: false)
    }
}
