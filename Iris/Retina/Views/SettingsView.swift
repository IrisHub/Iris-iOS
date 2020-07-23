//
//  SettingsView.swift
//  Iris
//
//  Created by Shalin on 7/18/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

//import SwiftUI
//
//struct SettingsView: View {
//
//    var body: some View {
//        ZStack {
//            List {
//                ForEach(0 ..< settings.count) { idx in
//                    SettingsCell(title: self.titles[idx], setting: self.settings[idx]).listRowInsets(EdgeInsets()).frame(width: UIScreen.screenWidth)
//                }
//
//                Divider().frame(height: 2).background(Color.retinaFontBtn).listRowInsets(EdgeInsets()).padding(.top, 24)
//
//                SettingsCell(title: "", setting: "Privacy Policy").listRowInsets(EdgeInsets()).frame(width: UIScreen.screenWidth)
//                SettingsCell(title: "", setting: "Terms of Service").listRowInsets(EdgeInsets()).frame(width: UIScreen.screenWidth)
//
//                HStack(alignment: .top) {
//                    Image("irissmall").resizable().foregroundColor(.white).padding(.trailing, 12).frame(width: 37, height: 34)
//                    VStack(alignment: .leading) {
//                        Text("Crafted for Shalin on May 22nd 2020").foregroundColor(.white)
//                        Text("User #3").foregroundColor(.white)
//                    }
//                }.padding([.top], 24)
//            }.onAppear {
//                UITableView.appearance().separatorStyle = .none
//                UITableViewCell.appearance().backgroundColor = .black
//                UITableView.appearance().backgroundColor = .black
//                UITableViewCell.appearance().selectionStyle = .none
//            }
//            .buttonStyle(PlainButtonStyle())
//            .navigationBarBackButtonHidden(true)
//            .navigationBarTitle("")
//            .navigationBarHidden(true)
//            .resignKeyboardOnDragGesture()
//        }
//    }
//}
//
//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(titles: ["Diet", "Food I don’t eat", "Time I have to cook Lunch", "Time I have to cook Dinner", "My cooking level", "Spice Tolerance", "See meals that are", "Top Cuisines"], settings: ["Vegan", "Eggs", "30min", "1 hour", "Intermediate", "Low", "Healthy", "American"])
//    }
//}
