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
    @State var preference: Preference
    @State var items: [PreferenceItem]

    var body: some View {
        VStack {
            TopNavigationView(title: "Your Cuisines", bolded: "", subtitle: preference.type == "single_select" ? "Select one option" : "Select multiple options", leftIconString: "chevron.left", rightIconStrings: ["", ""], buttonCommits: [{self.presentationMode.wrappedValue.dismiss()}, {}, {}])
            .edgesIgnoringSafeArea(.horizontal)
            .edgesIgnoringSafeArea(.top)
            
            if preference.type == "single_select" {
                SingleSelectView(items: items, preference: $preference)
            } else {
                MultiSelectView(items: items, preference: $preference)
            }
        }
        .background(Color.retinaBase)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

//struct ChangePreferenceView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChangePreferenceView(preference: <#Preference#>, items: <#[PreferenceItem]#>)
//    }
//}
