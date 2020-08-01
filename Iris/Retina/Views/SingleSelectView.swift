//
//  SingleSelectView.swift
//  Iris
//
//  Created by Shalin on 7/19/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct SingleSelectView: View {

    @Binding var items: [PreferenceItem]
    @Binding var preference: Preference


    var body: some View {
        ScrollView(.vertical) {
            ForEach(items, id: \.self) { item in
                SelectionCell(preference: self.$preference, items: self.$items, item: item, isSingleSelect: true)
                .listRowInsets(EdgeInsets())
            }
        }
    }
}

//struct SingleSelectView_Previews: PreviewProvider {
//    @State static var setting = ["pEars"]
//    static var previews: some View {
//        SingleSelectView(settings: ["apples", "pears", "bananas", "pineapples"], selectedSettings: $setting)
//    }
//}
