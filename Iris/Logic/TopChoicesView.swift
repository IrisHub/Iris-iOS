//
//  AlertView.swift
//  Iris
//
//  Created by Shalin on 7/21/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct TopChoicesView: View {
    var state: UIStateModel = UIStateModel()
    
    var body: some View {
        VStack {
            VStack() {
                TopNavigationView(title: "Your results for", bolded: "Chicken", subtitle: "Created for 3:20pm", leftIconString: "chevron.left", rightIconStrings: ["", ""])
            }
            .edgesIgnoringSafeArea(.horizontal)
            .edgesIgnoringSafeArea(.top)
            
            CarouselView(UIState: state)
        }
    }
}

struct TopChoicesView_Previews: PreviewProvider {
    static var previews: some View {
        TopChoicesView()
    }
}
