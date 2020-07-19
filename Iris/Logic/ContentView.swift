//
//  ContentView.swift
//  Iris
//
//  Created by Shalin on 7/16/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct Card {
    var title: String
    var shortcuts: [String]
}

struct DiscoveryItem: Hashable {
    var title: String
    var imageUrl: String
}


struct ContentView: View {
    let settings: [String]
    @State var selectedSettings: [String]

    var body: some View {
        List {
            ForEach(settings, id: \.self) { item in
                SelectionCell(title: item, selectedTitles: self.$selectedSettings, isSingleSelect: true)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    @State static var settings = ["pEars", "apples"]
    static var previews: some View {
        ContentView(settings: ["apples", "pears", "bananas", "pineapples"], selectedSettings: settings)
    }
}
