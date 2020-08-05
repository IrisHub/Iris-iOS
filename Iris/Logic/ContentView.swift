//
//  ContentView.swift
//  Iris
//
//  Created by Shalin on 7/16/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI
import Mixpanel

struct ContentView: View {
    let spacing: CGFloat
    
    let headerTop: String
    let headerMain: String
    let searchBarText: String
    
    @State var preferencesPresented: Bool = false
    @State var topChoicesPresented: Bool = false
    @ObservedObject var observed = Observer()
    @ObservedObject var observedTopChoices = TopChoicesObserver()
    
    @State var showPreferencesAlert: Bool = false


    init(spacing: CGFloat = 5) {
        self.spacing = spacing
        self.headerTop = "Header Top"
        self.headerMain = "Main Title"
        self.searchBarText = "Try a cuisine, ingredient, or dish"
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ZStack {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack(alignment: .top) {
                                    Spacer()
                                    Button(action: {
                                        Mixpanel.mainInstance().track(event: "Checking Preferences")
                                        if UserDefaults.standard.bool(forKey: "preferencesSeen") == false {
                                            self.showPreferencesAlert.toggle()
                                        } else {
                                            withAnimation {
                                                self.preferencesPresented = true
                                            }
                                        }
                                    }) {
                                        Image(systemName: "line.horizontal.3.decrease").foregroundColor(.retinaSnowWhite).retinaTypography(.h4_main)
                                    }.padding(.trailing, 24)
                                    .alert(isPresented: self.$showPreferencesAlert) {
                                        Alert(title: Text("Review your preferences at any time."), message: Text("Iris uses your preferences that don’t change often to filter results behind the scenes."), primaryButton: .default(Text("Review"), action: {
                                            UserDefaults.standard.set(true, forKey: "preferencesSeen")
                                            withAnimation {
                                                self.preferencesPresented = true
                                            }
                                        }), secondaryButton: .default(Text("Cancel")))
                                    }
                                }
                                
                                Text(self.observed.subtitle)
                                    .retinaTypography(.p5_main)
                                    .padding([.leading], 24)
                                    .foregroundColor(.retinaWinterGrey)
                                Text(self.observed.title)
                                    .retinaTypography(.h3_secondary)
                                    .padding([.leading], 24)
                                    .frame(width: UIScreen.screenWidth, alignment: .leading)
                                    .foregroundColor(.retinaSnowWhite)
                            }.frame(width: UIScreen.screenWidth, alignment: .leading).padding(.top, UIApplication.topInset*4)
                            
                            GeometryReader { geometry in
                                Rectangle().offset(y: -(geometry.frame(in: .global).minY)).foregroundColor(Color.retinaOverflow)
                                    .blur(radius: 20)
                                    .padding(-25)
                                    .frame(width: UIScreen.screenWidth, height: UIApplication.topInset*1.5)
                            }
                        }.zIndex(1)
                        
                        
                        
                        // Search view
                        GeometryReader { geometry in
                            NavigationLink(destination: LazyView(DiscoverySearch( observed: self.observed, observedTopChoices: self.observedTopChoices))) {
                                retinaSearchButton(text: self.searchBarText, color: .retinaOverlayDark, backgroundColor: .retinaOverflow, action: {}).allowsHitTesting(false)
                            }.offset(y: geometry.frame(in: .global).minY >= UIApplication.topInset ? max(0, geometry.frame(in: .global).minY/9) : -(geometry.frame(in: .global).minY - UIApplication.topInset))
                        }.frame(height: 60)
                            .zIndex(5)
                            .padding(.bottom, 24)
                            .padding(.top, 100)
                    
                        VStack {
                            HStack {
                                Text("Ingredient Suggestions").retinaTypography(.h5_main).padding(.leading, 24).padding(.top, 36).padding(.bottom, 12).foregroundColor(.retinaWinterGrey)
                                Spacer()
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(self.observed.discoveryItems.filter {
                                        $0.discover == true && $0.category == "ingredient"
                                    }, id: \.self) { item in
                                        NavigationLink(
                                        destination: LazyView(TopChoicesView(observed: self.observedTopChoices, selectedItem: item))) {
                                            DiscoveryCell(title: item.title, backgroundImageUrl: item.imageUrl).padding([.leading, .trailing], 6)
                                        }.buttonStyle(PlainButtonStyle())
                                    }
                                }.padding(.leading, 12)
                            }
                            
                            HStack {
                                Text("Dish Suggestions").retinaTypography(.h5_main).padding(.leading, 24).padding(.top, 36).foregroundColor(.retinaWinterGrey).padding(.bottom, 12)
                                Spacer()
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(self.observed.discoveryItems.filter {
                                        $0.discover == true && $0.category == "dish"
                                    }, id: \.self) { item in
                                        NavigationLink(
                                        destination: LazyView(TopChoicesView(observed: self.observedTopChoices, selectedItem: item))) {
                                            DiscoveryCell(title: item.title, backgroundImageUrl: item.imageUrl).padding([.leading, .trailing], 6)
                                        }.buttonStyle(PlainButtonStyle())
                                    }
                                }.padding(.leading, 12)
                            }
                            
                            
                            HStack {
                                Text("Cuisine Suggestions").retinaTypography(.h5_main).padding(.leading, 24).padding(.top, 36).foregroundColor(.retinaWinterGrey).padding(.bottom, 12)
                                Spacer()
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(self.observed.discoveryItems.filter {
                                        $0.discover == true && $0.category == "cuisine"
                                    }, id: \.self) { item in
                                        NavigationLink(
                                        destination: TopChoicesView(observed: self.observedTopChoices, selectedItem: item)) {
                                            DiscoveryCell(title: item.title, backgroundImageUrl: item.imageUrl).padding([.leading, .trailing], 6)
                                        }.buttonStyle(PlainButtonStyle())
                                    }
                                }.padding(.leading, 12).padding([.bottom], 120)
                            }
                        }.padding([.top], 48).background(Color.retinaSurface)
                    }
                }
                .background(Color.retinaOverflow)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)

            }.background(Color.retinaSurface)

            ZStack {
                PreferencesView(preferencesPresented: $preferencesPresented, observed: self.observed).padding([.top, .bottom], UIApplication.bottomInset)
                .offset(x: 0, y: self.preferencesPresented ? 0 : UIScreen.screenHeight + UIApplication.bottomInset)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(spacing: -10)
        }
    }
}
