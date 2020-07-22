//
//  PreferencesView.swift
//  Iris
//
//  Created by Shalin on 7/22/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct PreferencesView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Your filters")
                    .retinaTypography(.h3)
                    .padding(.leading, 24)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "xmark").foregroundColor(.white).padding(.trailing, 24).retinaTypography(.h4)
            }.padding(.top, 80)
            
            SettingsView(titles: ["Diet", "Food I don’t eat", "Time I have to cook Lunch", "Time I have to cook Dinner", "My cooking level", "Spice Tolerance", "See meals that are", "Top Cuisines"], settings: ["Vegan", "Eggs", "30min", "1 hour", "Intermediate", "Low", "Healthy", "American"])
            
            
            
        }.background(Color.black).edgesIgnoringSafeArea(.top)
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
