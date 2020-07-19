//
//  SettingsView.swift
//  Iris
//
//  Created by Shalin on 7/18/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var titles: [String]
    var settings: [String]

    
    var body: some View {
        ZStack {
            Color.retinaFontBtn
            VStack {
                ForEach(0 ..< settings.count) { idx in
                    SettingsCell(title: self.titles[idx], setting: self.settings[idx]).frame(width: UIScreen.screenWidth, height: 72)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(titles: ["Diet", "Food I don’t eat", "Time I have to cook Lunch", "Time I have to cook Dinner", "My cooking level", "Spice Tolerance", "See meals that are", "Top Cuisines"], settings: ["Vegan", "Eggs", "30min", "1 hour", "Intermediate", "Low", "Healthy", "American"])
    }
}
