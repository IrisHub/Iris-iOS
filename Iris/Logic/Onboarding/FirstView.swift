//
//  FirstViewController.swift
//  Iris
//
//  Created by Shalin on 7/25/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

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
                    .frame(width: UIScreen.screenWidth, height: 120)
                    
                    HStack {
                        retinaButton(text: "Enter Invite Code", style: .outlineOnly, color: .retinaPink, action: { withAnimation { self.secondPresented = true } }).frame(width: 326, height: 36, alignment: .trailing)
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
