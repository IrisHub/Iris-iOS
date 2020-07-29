//
//  AlertView.swift
//  Iris
//
//  Created by Shalin on 7/21/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON



struct TopChoicesView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var state: UIStateModel = UIStateModel()
    @State var recipePresented: Bool = false
    @State var showBanner:Bool = false
    @State var bannerData: BannerModifier.BannerData = BannerModifier.BannerData(title: "", detail: "Iris will show fewer results like that from now on.", type: .Warning)
    @ObservedObject var observed: TopChoicesObserver
    @State var selectedChoice: Int = 0

    var body: some View {
        ZStack {
            VStack {
                VStack() {
                    TopNavigationView(title: observed.title, bolded: observed.item, subtitle: observed.subtitle, leftIconString: "chevron.left", rightIconStrings: ["", ""], buttonCommits: [{self.presentationMode.wrappedValue.dismiss()}, {}, {}])
                }
                .edgesIgnoringSafeArea(.horizontal)
                .edgesIgnoringSafeArea(.top)
                
                CarouselView(UIState: state, showBanner: $showBanner, recipePresented: $recipePresented, selectedChoice: self.$selectedChoice, observed: self.observed, feedbackCommit: self.feedback)
            }
            .background(Color.retinaBase)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)

            ZStack {
                RecipeView(observed: self.observed, selectedChoice: self.selectedChoice, recipePresented: self.$recipePresented)
            }
            .edgesIgnoringSafeArea(.all)
            .offset(x: 0, y: self.recipePresented ? 0 : UIScreen.screenHeight + UIApplication.bottomInset)

        }
        .banner(data: self.$bannerData, show: self.$showBanner)
    }
    
    
    func feedback() {
        struct Feedback: Codable {
            var user_id: String = "17ef5c4b-3ac9-4548-a309-41e30a61c6e8"
            var recipe_id: String
        }

        do {
            let recipe = Feedback(recipe_id: self.observed.recipes.count == 0 ? "" : self.observed.recipes[selectedChoice].id)
            let jsonData = try JSONEncoder().encode(recipe)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            
            let parameters = convertToDictionary(text: jsonString)
            let headers : HTTPHeaders = ["Content-Type": "application/json"]
            AF.request("https://e2nmwaykqf.execute-api.us-west-1.amazonaws.com/alpha/reciperate", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                print(response)
            }

        } catch { print(error) }
    }
}

//struct TopChoicesView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopChoicesView()
//    }
//}
