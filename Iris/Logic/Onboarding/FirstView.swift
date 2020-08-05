//
//  FirstViewController.swift
//  Iris
//
//  Created by Shalin on 7/25/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI
import Mixpanel

struct FirstView: View {
    @Binding var secondPresented: Bool

    var body: some View {
        VStack {
            VStack {
                Text("Welcome").retinaTypography(.h1_secondary).foregroundColor(.retinaSnowWhite)
                Text("Iris is your helpful assistant.").retinaTypography(.p5_main).foregroundColor(.retinaWinterGrey)
            }.padding(.top, UIScreen.screenHeight/4)
            Spacer()
            Group {
                ZStack {
                    Rectangle()
                    .foregroundColor(Color.retinaOverlayDark)
                    .frame(width: UIScreen.screenWidth, height: 100)
                    
                    HStack {
                        retinaButton(text: "Enter Invite Code", style: .outlineOnly, color: .retinaPink, action: {
                            Mixpanel.mainInstance().track(event: "Started Onboarding")
                            withAnimation { self.secondPresented = true } }).frame(width: UIScreen.screenWidth-48, height: 36, alignment: .trailing)
                    }
                }
            }
        }
        .background(Color.retinaBase)
        .edgesIgnoringSafeArea(.all)
    }
}

struct FirstView_Previews: PreviewProvider {
    @State static var secondPresented: Bool = false

    static var previews: some View {
        FirstView(secondPresented: $secondPresented)
    }
}
