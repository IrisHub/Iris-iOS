//
//  SingleSelectView.swift
//  Iris
//
//  Created by Shalin on 7/19/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct SingleSelectView: View {

    let settings: [String]
    @Binding var selectedSettings: [String]

    var body: some View {
        ScrollView(.vertical) {
            ForEach(settings, id: \.self) { item in
                SelectionCell(title: item, selectedTitles: self.$selectedSettings, isSingleSelect: true)
                .listRowInsets(EdgeInsets())
            }
        }
    }
}

struct SingleSelectView_Previews: PreviewProvider {
    @State static var setting = ["pEars"]
    static var previews: some View {
        SingleSelectView(settings: ["apples", "pears", "bananas", "pineapples"], selectedSettings: $setting)
    }
}
