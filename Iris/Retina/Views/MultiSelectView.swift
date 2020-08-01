//
//  MultiSelectView.swift
//  Iris
//
//  Created by Shalin on 7/19/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct MultiSelectView: View {

    @Binding var items: [PreferenceItem]
    @Binding var preference: Preference

    var body: some View {
        ScrollView(.vertical) {
            ForEach(items, id: \.self) { item in
                SelectionCell(preference: self.$preference, items: self.$items, item: item, isSingleSelect: false)
                .listRowInsets(EdgeInsets())
            }
        }
    }
}
