//
//  OnboardingFlowView.swift
//  Iris
//
//  Created by Shalin on 7/29/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct OnboardingFlowView: View {
    @State var secondPresented: Bool = false
    @State var thirdPresented: Bool = false
    @State var fourthPresented: Bool = false
    @State var preferencesPresented: Bool = false
    @State var preferences: [String] = [String]()

    var body: some View {
        ZStack {
            FirstView(secondPresented: self.$secondPresented)
                .padding([.top, .bottom], UIApplication.bottomInset)

            ZStack {
                SecondView(thirdPresented: self.$thirdPresented, preferences: self.$preferences)
                    .padding([.top, .bottom], UIApplication.bottomInset)
            }
            .offset(x: 0, y: self.secondPresented ? 0 : UIScreen.screenHeight + UIApplication.bottomInset)
            
            if (self.secondPresented) {
                ZStack {
                    ThirdView(fourthPresented: self.$fourthPresented, preferences: self.$preferences)
                        .padding([.top, .bottom], UIApplication.bottomInset)
                }
                .offset(x: 0, y: self.thirdPresented ? 0 : UIScreen.screenHeight + UIApplication.bottomInset)
            }

            if (self.thirdPresented) {
                ZStack {
                    ContentView(spacing: -10)
                        .padding([.top, .bottom], UIApplication.bottomInset)
                }
                .offset(x: 0, y: self.fourthPresented ? 0 : UIScreen.screenHeight + UIApplication.bottomInset)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct OnboardingFlowView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFlowView()
    }
}
