//
//  ChangePreferenceView.swift
//  Iris
//
//  Created by Shalin on 7/22/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI
import Alamofire

struct ChangePreferenceView: View {
    @ObservedObject var observed: Observer
    @State var preference: Preference
    @State var items: [PreferenceItem]
    
    @Binding var changePreferencePresented: Bool

    var body: some View {
        VStack {
            TopNavigationView(title: "Your Cuisines", bolded: "", subtitle: preference.type == "single_select" ? "Select one option" : "Select multiple options", leftIconString: "chevron.left", rightIconStrings: ["", ""], buttonCommits: [{self.changePreferencePresented = false; self.convertToJSON()}, {}, {}])
            .edgesIgnoringSafeArea(.horizontal)
            .edgesIgnoringSafeArea(.top)
            
            if preference.type == "single_select" {
                SingleSelectView(items: $items, preference: $preference)
            } else {
                MultiSelectView(items: $items, preference: $preference)
            }
        }
        .background(Color.retinaBase)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
        
    func convertToJSON() {
        struct ChangedPreference: Codable {
            var user_id: String = UserDefaults.standard.string(forKey: "userID") ?? ""
            var preference: Preference
        }

        // Updates the table for the User
        if let location = self.observed.preferences.firstIndex(where: {$0.title.caseInsensitiveCompare(self.preference.title) == .orderedSame}) {
            self.observed.preferences[location] = self.preference
        }

        // Create a copy of the preference so we can filter out items that are not selected
        var preference: Preference = self.preference
        preference.items = self.items.filter { $0.selected }

        do {
            let pref = ChangedPreference(preference: preference)
            let jsonData = try JSONEncoder().encode(pref)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            
            let parameters = convertToDictionary(text: jsonString)
            let headers : HTTPHeaders = ["Content-Type": "application/json"]
            AF.request("https://e2nmwaykqf.execute-api.us-west-1.amazonaws.com/alpha/preferencesupdate", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                print(response)
            }
            
        } catch { print(error) }
    }
}

//struct ChangePreferenceView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChangePreferenceView(preference: <#Preference#>, items: <#[PreferenceItem]#>)
//    }
//}
