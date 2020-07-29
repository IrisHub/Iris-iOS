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

class TopChoicesObserver : ObservableObject{
    init() {
        getTopChoices()
    }
        
    @Published var recipes = [Recipe]()
    @Published var category: String = "ingredient"
    @Published var title: String = "None"
    @Published var item: String = "None"
    @Published var subtitle: String = "None"

    func getTopChoices() {
        let parameters = [
            "user_id": "17ef5c4b-3ac9-4548-a309-41e30a61c6e8",
            "query_type": "ingredient",
            "query_body": "Chicken"
        ]
        let headers : HTTPHeaders = ["Content-Type": "application/json"]
        AF.request("https://e2nmwaykqf.execute-api.us-west-1.amazonaws.com/alpha/cookingcardresults", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
            do {
                let json = try JSON(data: response.data ?? Data(), options: .allowFragments)
                print(json)
                if let category = json["category"].string {
                    self.category = category
                }
                if let title = json["title"].string {
                    self.title = title
                }
                if let item = json["item"].string {
                    self.item = item
                }
                if let subtitle = json["subtitle"].string {
                    self.subtitle = subtitle
                }

                for (_,subJson):(String, JSON) in json["results"] {
                    self.recipes.append(Recipe(id: subJson["id"].stringValue, title: subJson["title"].stringValue, rating: subJson["rating"].stringValue, cookTime: subJson["cook_time"].stringValue, difficulty: subJson["difficulty"].stringValue, imageUrl: subJson["image_url"].stringValue, ingredients: subJson["ingredients"].arrayValue.map { $0.stringValue}, link: subJson["link"].stringValue))
                }
            } catch {
                print("error")
            }
        }
    }

}


struct TopChoicesView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var state: UIStateModel = UIStateModel()
    @State var recipePresented: Bool = false
    @State var showBanner:Bool = false
    @State var bannerData: BannerModifier.BannerData = BannerModifier.BannerData(title: "", detail: "Iris will show fewer results like that from now on.", type: .Warning)
    @ObservedObject var observed = TopChoicesObserver()
    @State var selectedChoice: Int = 0

    var body: some View {
        ZStack {
            VStack {
                VStack() {
                    TopNavigationView(title: observed.title, bolded: observed.item, subtitle: observed.subtitle, leftIconString: "chevron.left", rightIconStrings: ["", ""], buttonCommits: [{self.presentationMode.wrappedValue.dismiss()}, {}, {}])
                }
                .edgesIgnoringSafeArea(.horizontal)
                .edgesIgnoringSafeArea(.top)
                
                CarouselView(UIState: state, showBanner: $showBanner, recipePresented: $recipePresented, selectedChoice: self.$selectedChoice, observed: self.observed)
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
}

//struct TopChoicesView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopChoicesView()
//    }
//}
