//
//  AlertView.swift
//  Iris
//
//  Created by Shalin on 7/21/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct TopChoicesView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var state: UIStateModel = UIStateModel()
    @State var recipePresented: Bool = false
    @State var showBanner:Bool = false
    @State var bannerData: BannerModifier.BannerData = BannerModifier.BannerData(title: "", detail: "Iris will show fewer results like that from now on.", type: .Warning)

    var body: some View {
        ZStack {
            VStack {
                VStack() {
                    TopNavigationView(title: "Your results for", bolded: "Chicken", subtitle: "Created for 3:20pm", leftIconString: "chevron.left", rightIconStrings: ["", ""], buttonCommits: [{self.presentationMode.wrappedValue.dismiss()}, {}, {}])
                }
                .edgesIgnoringSafeArea(.horizontal)
                .edgesIgnoringSafeArea(.top)
                
                CarouselView(UIState: state, showBanner: $showBanner, recipePresented: $recipePresented)
            }
            .background(Color.retinaBase)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)

            ZStack {
                RecipeView(recipePresented: self.$recipePresented)
            }
            .edgesIgnoringSafeArea(.all)
            .offset(x: 0, y: self.recipePresented ? 0 : UIScreen.screenHeight + UIApplication.bottomInset)

        }
        .banner(data: self.$bannerData, show: self.$showBanner)

    }
}

struct TopChoicesView_Previews: PreviewProvider {
    static var previews: some View {
        TopChoicesView()
    }
}
