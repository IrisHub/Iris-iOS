//
//  TopNavigationView.swift
//  Iris
//
//  Created by Shalin on 7/21/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct TopNavigationView: View {
    var title : String
    var bolded: String
    var subtitle: String = ""
    var leftIconString: String
    var rightIconStrings : [String]
    var buttonCommits : [()->()] = [{}, {}, {}]
    
    var body: some View {
        
        HStack {
            Group {
                Button(action:
                    self.buttonCommits[0]
                ) {
                    Image(systemName: self.leftIconString)
                        .foregroundColor(Color.retinaWinterGrey)
                        .padding(.horizontal, 4)
                        .retinaTypography(.h5_main)
                }

                Spacer()
                
                VStack {
                    HStack {
                        Text(bolded.isEmpty ? self.title : self.title + "").retinaTypography(.p5_main, color: .retinaSnowWhite).offset(y: self.subtitle == "" ? 5: 0)
                        Text(!bolded.isEmpty ? bolded : "").retinaTypography(.h5_main, color: .retinaSnowWhite).padding(-3)
                    }
                    Text(self.subtitle).retinaTypography(.p6_main, color: .retinaWinterGrey).padding(.top, self.subtitle == "" ? 0: 5)
                }
                .offset(x: 23, y: 0)
                
                Spacer()
                
                HStack(spacing: 22){
                    Button(action: self.buttonCommits[1]) {
                        Image(systemName: self.rightIconStrings[0])
                            .foregroundColor(Color.gray)
                            .padding(.horizontal, 4)
                            .retinaTypography(.h5_main)

                    }
                    Button(action: self.buttonCommits[2]) {
                        Image(systemName: self.rightIconStrings[1])
                            .foregroundColor(Color.gray)
                            .padding(.horizontal, 4)
                            .retinaTypography(.h5_main)
                    }
                }
                .buttonStyle(RightNavButtonStyle())
                .padding(.horizontal, 4)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(Color.retinaOverlayDark)
        .clipped()
//        .shadow(color: Color.retinaBasic, radius: 3, x: 0, y: 0)
        .animation(.default)
    }
}

struct RightNavButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.white: Color.gray)
    }
}

struct LeftNavButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.white: Color.gray)
    }
}


struct TopNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        VStack() {
            
            TopNavigationView(title: "Your results for", bolded: "Chicken", subtitle: "Created for 3:20pm", leftIconString: "chevron.left", rightIconStrings: ["", ""])

            Spacer()
        }
        .edgesIgnoringSafeArea(.horizontal)
        .edgesIgnoringSafeArea(.top)
    }
}
