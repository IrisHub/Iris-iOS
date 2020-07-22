//
//  MultiSelectView.swift
//  Iris
//
//  Created by Shalin on 7/19/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct MultiSelectView: View {

    let settings: [String]
    @State var selectedSettings: [String]

    var body: some View {
        List {
            ForEach(settings, id: \.self) { item in
                SelectionCell(title: item, selectedTitles: self.$selectedSettings, isSingleSelect: false)
                .listRowInsets(EdgeInsets())
            }
        }.onAppear {
            UITableView.appearance().separatorStyle = .none
            UITableViewCell.appearance().backgroundColor = .black
            UITableView.appearance().backgroundColor = .black
        }
    }
}

struct MultiSelectView_Previews: PreviewProvider {
    @State static var settings = ["pEars", "apples"]
    static var previews: some View {
        MultiSelectView(settings: ["apples", "pears", "bananas", "pineapples"], selectedSettings: settings)
    }
}
