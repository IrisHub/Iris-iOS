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
import Mixpanel


struct TopChoicesView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var state: UIStateModel = UIStateModel()

    @ObservedObject var observed: TopChoicesObserver
    @State var selectedItem: DiscoveryItem

    @State var recipePresented: Bool = false
    @State var showBanner:Bool = false
    @State var bannerData: BannerModifier.BannerData = BannerModifier.BannerData(title: "", detail: "Iris will show fewer results like that from now on.", type: .Warning)
    @State var selectedChoice: Int = 0
    
//    @Binding var topChoicesPresented: Bool
    
    var body: some View {
        ZStack {
            VStack {
                TopNavigationView(title: observed.title, bolded: observed.item, subtitle: observed.subtitle, leftIconString: "chevron.left", rightIconStrings: ["", ""], buttonCommit: { self.goBack() })
                
                CarouselView(UIState: state, showBanner: $showBanner, recipePresented: $recipePresented, selectedChoice: self.$selectedChoice, observed: self.observed, feedbackCommit: self.feedback)
            }
            .background(Color.retinaBase)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)

            ZStack {
                RecipeView(observed: self.observed, selectedChoice: self.selectedChoice, recipePresented: self.$recipePresented)
                .offset(x: 0, y: self.recipePresented ? 0 : UIScreen.screenHeight + UIApplication.bottomInset)
            }
            

        }.padding(.top, UIApplication.topInset)
        .edgesIgnoringSafeArea(.all)
        .banner(data: self.$bannerData, show: self.$showBanner)
        .onAppear() {
            self.observed.getTopChoices(queryString: self.selectedItem.title, queryType: self.selectedItem.category)
        }
    }
    
    func goBack() {
        self.observed.clearTopChoices()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    
    func feedback() {
        struct Feedback: Codable {
            var user_id: String = UserDefaults.standard.string(forKey: "userID") ?? ""
            var recipe_id: String
        }

        do {
            print("self.selectedChoice", self.selectedChoice)
            print("self.observed.recipes", self.observed.recipes[self.selectedChoice])
            let recipe = Feedback(recipe_id: self.observed.recipes.count == 0 ? "" : self.observed.recipes[self.selectedChoice].id)
            let jsonData = try JSONEncoder().encode(recipe)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            
            let parameters = convertToDictionary(text: jsonString)
            let headers : HTTPHeaders = ["Content-Type": "application/json"]
            AF.request("https://e2nmwaykqf.execute-api.us-west-1.amazonaws.com/alpha/reciperate", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                Mixpanel.mainInstance().track(event: "Recipe Flagged")
                print(response)
            }

        } catch { print(error) }
    }
}

struct TopChoicesView_Previews: PreviewProvider {
    @ObservedObject static var observedTopChoices = TopChoicesObserver()
    @State static var discovery = DiscoveryItem(id: "1", title: "Chicken", imageUrl: "", category: "ingredient", discover: false, ideas: false)

    static var previews: some View {
//        TopChoicesView(observed: self.observedTopChoices, selectedItem: discovery)
        TopChoicesView(observed: self.observedTopChoices, selectedItem: discovery)
    }
}
