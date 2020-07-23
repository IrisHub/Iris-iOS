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

    var body: some View {
            VStack {
                VStack() {
                    TopNavigationView(title: "Your results for", bolded: "Chicken", subtitle: "Created for 3:20pm", leftIconString: "chevron.left", rightIconStrings: ["", ""], buttonCommits: [{self.presentationMode.wrappedValue.dismiss()}, {}, {}])
                }
                .edgesIgnoringSafeArea(.horizontal)
                .edgesIgnoringSafeArea(.top)
                
                CarouselView(UIState: state, commitDestination: RecipeView())

            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct TopChoicesView_Previews: PreviewProvider {
    static var previews: some View {
        TopChoicesView()
    }
}
