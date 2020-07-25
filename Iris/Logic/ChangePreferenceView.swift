//
//  ChangePreferenceView.swift
//  Iris
//
//  Created by Shalin on 7/22/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct ChangePreferenceView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State static var settings = ["pEars", "apples"]

    var body: some View {
        VStack {
            TopNavigationView(title: "Your Cuisines", bolded: "", subtitle: "Select multiple options", leftIconString: "chevron.left", rightIconStrings: ["", ""], buttonCommits: [{self.presentationMode.wrappedValue.dismiss()}, {}, {}])
            .edgesIgnoringSafeArea(.horizontal)
            .edgesIgnoringSafeArea(.top)
            
            MultiSelectView(settings: ["apples", "pears", "bananas", "pineapples"], selectedSettings: ChangePreferenceView.settings)
        }
        .background(Color.retinaBase)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct ChangePreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePreferenceView()
    }
}
