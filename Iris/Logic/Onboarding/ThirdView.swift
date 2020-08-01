//
//  ThirdView.swift
//  Iris
//
//  Created by Shalin on 7/25/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct ThirdView: View {
    @Binding var fourthPresented: Bool
    @Binding var preferences: [String]
    @State private var number = -1
    
    @State private var shownPreferences: [String] = [String]()
    @State private var showNextButton = false

    @State var currentDate = Date()
    let timer = Timer.publish(every: 1.3, on: .main, in: .common).autoconnect()
    @State private var showFirst = false
    @State private var showSecond = false


    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                HStack() {
                    VStack(alignment: .leading) {
                        if (preferences.count != 0) {
                            VStack(alignment: .leading) {
                                if showFirst {
                                    Text(preferences[0])
                                        .retinaTypography(.h3_secondary)
                                        .foregroundColor(.retinaSnowWhite)
                                        .padding(.bottom, 12)
                                        .padding(.top, 12)
                                        .transition(.opacity)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                if showSecond {
                                    Text(preferences[1])
                                        .retinaTypography(.p5_main)
                                        .foregroundColor(.retinaWinterGrey)
                                        .padding(.bottom, 12)
                                        .padding(.top, 12)
                                        .transition(.opacity)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            
                                ForEach(shownPreferences, id: \.self) { pref in
                                    Text(pref)
                                        .retinaTypography(.h4_secondary)
                                        .foregroundColor(.retinaSnowWhite)
                                        .padding(.bottom, 12)
                                        .padding(.top, 12)
                                        .listRowInsets(EdgeInsets()).transition(.opacity)
                                        .fixedSize(horizontal: false, vertical: true)
                                }.onReceive(self.timer) { _ in
                                    self.delayText()
                                }
                            }
                        }
                    }.padding(.top, UIScreen.screenHeight/8).padding([.leading, .trailing], 24)
                    Spacer()
                }
            }
            if (self.showNextButton) {
                ZStack {
                    Rectangle()
                    .foregroundColor(Color.retinaOverlayDark)
                    .frame(width: UIScreen.screenWidth, height: 120)

                    HStack {
                        retinaButton(text: "Unlock your Iris", style: .outlineOnly, color: .retinaPink, action: { withAnimation { self.fourthPresented = true } }).frame(width: 326, height: 36, alignment: .trailing).transition(.slide)
                    }
                }.padding(.bottom, DeviceUtility.isIphoneXType ? 0 : UIApplication.bottomInset)
            }
        }
        .background(Color.retinaBase)
        .edgesIgnoringSafeArea(.all)

    }
    
    func delayText() {
        self.number = self.number + 1
        if self.number == 0 {
            withAnimation(.linear(duration: 0.25)) {
                self.showFirst = true
            }
            return
        }
        if self.number == 1 {
            withAnimation(.linear(duration: 0.25)) {
                self.showSecond = true
            }
            return
        }
        
        
        if (self.number < self.preferences.count) {
            withAnimation(.linear(duration: 0.25)) {
                self.shownPreferences.append(self.preferences[self.number])
            }
        } else {
            withAnimation(.easeOut(duration: 0.25)) {
                self.showNextButton = true
            }
            self.timer.upstream.connect().cancel()
        }
    }
}

struct ThirdView_Previews: PreviewProvider {
    @State static var fourthPresented: Bool = false
    @State static var preferences: [String] = [String]()

    static var previews: some View {
        ThirdView(fourthPresented: $fourthPresented, preferences: $preferences)
    }
}
