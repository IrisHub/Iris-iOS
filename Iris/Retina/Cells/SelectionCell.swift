//
//  SelectionCell.swift
//  Iris
//
//  Created by Shalin on 7/18/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct SelectionCell: View {

    @Binding var preference: Preference
    @Binding var items: [PreferenceItem]
    @State var item: PreferenceItem
    var isSingleSelect: Bool
    

    var body: some View {
        Button(action: {
            if !self.isSingleSelect {
                if (self.items.contains(where: {$0.title.caseInsensitiveCompare(self.item.title) == .orderedSame && $0.selected})) {
                    // it was selected before, now unselect it
                    if let location = self.items.firstIndex(where: {$0.title.caseInsensitiveCompare(self.item.title) == .orderedSame && $0.selected}) {
                        self.items[location].selected = false
                    }
                } else {
                    // it was not selected before, now select it
                    if let location = self.items.firstIndex(where: {$0.title.caseInsensitiveCompare(self.item.title) == .orderedSame}) {
                        self.items[location].selected = true
                    }
                }
                self.preference.items = self.items
            } else {
                // set all items to unselected
                
                // set current one to selected
                for idx in 0..<self.items.count {
                    self.items[idx].selected = false
                }
                
                if let location = self.items.firstIndex(where: {$0.title.caseInsensitiveCompare(self.item.title) == .orderedSame}) {
                    self.items[location].selected = true
                }
                self.preference.items = self.items
            }
        }) {
            ZStack(alignment: .leading) {
                Rectangle().frame(width: UIScreen.screenWidth, height: 72).foregroundColor(.retinaBase)
                HStack {
                    Circle()
                        .fill(self.items.contains(where: {$0.title.caseInsensitiveCompare(self.item.title) == .orderedSame && $0.selected}) ? Color.white : Color.retinaBase)
                        .frame(width: 8, height: 8)
                        .padding(.leading, 24)
                    
                    Text(item.title.capitalizingFirstLetter()).foregroundColor(.white).retinaTypography(.h5_main).fixedSize(horizontal: false, vertical: true).frame(width: 204, alignment: .leading).padding(.leading, 12)
                }
            }
        }
    }
}

//
//struct SelectionCell_Previews: PreviewProvider {
//    @State static var selected = ["Vegetarian", "Vegan"]
//    static var previews: some View {
//        SelectionCell(title: "Vegetarian", selectedTitles: $selected, isSingleSelect: false)
//    }
//}
