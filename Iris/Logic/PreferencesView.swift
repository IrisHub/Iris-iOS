//
//  PreferencesView.swift
//  Iris
//
//  Created by Shalin on 7/22/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct PreferencesView: View {
    @Binding var preferencesPresented: Bool
    @ObservedObject var observed: Observer
    @State var changePreferencePresented: Bool = false

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
                        
                        Button(action: {
                            withAnimation {
                                self.preferencesPresented = false
                            }
                        }) {
                            Image(systemName: "xmark").foregroundColor(.white).retinaTypography(.h5_main)
                        }.padding(.trailing, 24)
                    }.padding(.top, 80)
                    
                    ScrollView(.vertical) {
                        ForEach(self.observed.preferences, id: \.self) { preference in
                            ZStack {
                                NavigationLink(destination: LazyView(ChangePreferenceView(observed: self.observed, preference: preference, items: preference.items, changePreferencePresented: self.$changePreferencePresented))) {
                                    SettingsCell(preference: preference)
                                }
                            }
                        }
                        
                        Divider().frame(height: 2).background(Color.retinaOverlayDark).listRowInsets(EdgeInsets()).padding(.top, 24)
                        
                        NavigationLink(destination: LazyView(InformationView(type: .privacy))) {
                            SettingsCell(preference: Preference(id: "", title: "", type: "", items: []), title: "Privacy Policy").listRowInsets(EdgeInsets())
                        }
                        
                        NavigationLink(destination: LazyView(InformationView(type: .tos))) {
                            SettingsCell(preference: Preference(id: "", title: "", type: "", items: []), title: "Terms of Service").listRowInsets(EdgeInsets())
                        }
                        
                        HStack(alignment: .top) {
                            Image("irissmall").resizable().padding(.trailing, 12).frame(width: 37, height: 33)
                            VStack(alignment: .leading) {
                                Text(observed.etching).foregroundColor(.retinaWinterGrey).retinaTypography(.p6_secondary)
                                Text(observed.userNumber).foregroundColor(.retinaWinterGrey).retinaTypography(.p6_secondary)
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
    @ObservedObject static var observed = Observer()

    static var previews: some View {
        PreferencesView(preferencesPresented: $preferencesPresented, observed: self.observed)
    }
}
