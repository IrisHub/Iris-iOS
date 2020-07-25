//
//  FourthView.swift
//  Iris
//
//  Created by Shalin on 7/25/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct FourthView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("Hello, Katherine").retinaTypography(.h4_secondary).foregroundColor(.retinaSnowWhite).padding(.bottom, 12).padding(.top, 12)
                    Text("Welcome to Iris").retinaTypography(.h4_secondary).foregroundColor(.retinaSnowWhite).padding(.bottom, 12).padding(.top, 12)
                    Text("We’re customizing this with some of your preferences:").retinaTypography(.h4_secondary).foregroundColor(.retinaSnowWhite).padding(.bottom, 12).padding(.top, 12)
                }.padding(.top, UIScreen.screenHeight/4).padding([.leading, .trailing], 12)
                Spacer()
            }
            Spacer()
        }
        .background(Color.retinaBase)
        .edgesIgnoringSafeArea(.all)
    }
}

struct FourthView_Previews: PreviewProvider {
    static var previews: some View {
        FourthView()
    }
}
