//
//  PreferencesView.swift
//  Iris
//
//  Created by Shalin on 7/22/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct PreferencesView: View {
    var titles: [String]
    var settings: [String]
    @Binding var preferencesPresented: Bool

    var body: some View {
        NavigationView {
            ZStack {
                Color.retinaBase.edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Text("Your filters")
                            .retinaTypography(.h4_secondary)
                            .foregroundColor(.white)
                        .padding(.leading, 24)
                        Spacer()
    //                    Image(systemName: "xmark").foregroundColor(.white).retinaTypography(.h4).padding(.trailing, 24)
                        
                        Button(action: {
                            withAnimation {
                                self.preferencesPresented.toggle()
                            }
                        }) {
                            Image(systemName: "xmark").foregroundColor(.white).retinaTypography(.h5_main)
                        }.padding(.trailing, 24)

                        
                    }.padding(.top, 80)
                    
                    ScrollView(.vertical) {
                        ForEach(0 ..< settings.count) { idx in
                            ZStack {
                                NavigationLink(destination: ChangePreferenceView()) {
                                    SettingsCell(title: self.titles[idx], setting: self.settings[idx]).listRowInsets(EdgeInsets())
                                }
                            }
                        }
                        
                        Divider().frame(height: 2).background(Color.retinaOverlayDark).listRowInsets(EdgeInsets()).padding(.top, 24)

                        SettingsCell(title: "", setting: "Privacy Policy").listRowInsets(EdgeInsets())
                        SettingsCell(title: "", setting: "Terms of Service").listRowInsets(EdgeInsets())
                        
                        HStack(alignment: .top) {
                            Image("irissmall").resizable().padding(.trailing, 12).frame(width: 37, height: 33)
                            VStack(alignment: .leading) {
                                Text("Crafted for Shalin on May 22nd 2020").foregroundColor(.retinaWinterGrey).retinaTypography(.p6_secondary)
                                Text("User #1").foregroundColor(.retinaWinterGrey).retinaTypography(.p6_secondary)
                            }
                            Spacer()
                        }.padding([.top,.leading,.bottom], 24)
                    }
                }.edgesIgnoringSafeArea([.top])
            }
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    @State static var preferencesPresented: Bool = false

    static var previews: some View {
        PreferencesView(titles: ["Diet", "Food I don’t eat", "Time I have to cook Lunch", "Time I have to cook Dinner", "My cooking level", "Spice Tolerance", "See meals that are", "Top Cuisines"], settings: ["Vegan", "Eggs", "30min", "1 hour", "Intermediate", "Low", "Healthy", "American"], preferencesPresented: $preferencesPresented)
    }
}
