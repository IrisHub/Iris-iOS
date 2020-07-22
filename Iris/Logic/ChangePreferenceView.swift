//
//  ChangePreferenceView.swift
//  Iris
//
//  Created by Shalin on 7/22/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct ChangePreferenceView: View {
    @State static var settings = ["pEars", "apples"]

    var body: some View {
        VStack {
            VStack() {
                TopNavigationView(title: "Your Cuisines", bolded: "", subtitle: "Select multiple options", leftIconString: "chevron.left", rightIconStrings: ["", ""])
            }
            .edgesIgnoringSafeArea(.horizontal)
            .edgesIgnoringSafeArea(.top)
            
            MultiSelectView(settings: ["apples", "pears", "bananas", "pineapples"], selectedSettings: ChangePreferenceView.settings)
        }.background(Color.black)
    }
}

struct ChangePreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePreferenceView()
    }
}
