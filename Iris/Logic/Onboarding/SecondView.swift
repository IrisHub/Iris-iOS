//
//  SecondView.swift
//  Iris
//
//  Created by Shalin on 7/25/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    @State var value: CGFloat = 0
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("What's your invite code?").retinaTypography(.h4_secondary).foregroundColor(.retinaSnowWhite).padding([.leading, .bottom], 24)
                RetinaTextField("123456", onCommit: {print("party")})
            }.padding(.top, UIScreen.screenHeight/5)
            Spacer()
            Group {
                ZStack {
                    Rectangle()
                    .foregroundColor(Color.retinaOverlayDark)
                    .frame(width: UIScreen.screenWidth, height: 120)
                    
                    HStack {
                        retinaButton(text: "Submit", style: .outlineOnly, color: .retinaPink, action: {
                        }).frame(width: 326, height: 36, alignment: .trailing)
                    }
                }
            }
            .offset(y: -self.value)
            .animation(.spring())
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) {
                    (notif) in
                    if let rect = notif.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
                        let keyboardHeight = rect.height
                        self.value = keyboardHeight
                    }
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {
                    (notif) in
                    self.value = 0
                }
            }

        }
        .background(Color.retinaBase)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
