//
//  Observers.swift
//  Iris
//
//  Created by Shalin on 7/31/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import Mixpanel

struct Card {
    var title: String
    var shortcuts: [String]
}

struct DiscoveryItem: Hashable, Identifiable, Codable {
    var id: String = "1"
    var title: String
    var imageUrl: String
    var category: String
    var discover: Bool = false
    var ideas: Bool = false
}

struct PreferenceItem: Hashable, Identifiable, Codable {
    var id: String = "1"
    var title: String
    var selected: Bool = false
}

struct Preference: Hashable, Identifiable, Codable {
    var id: String = "1"
    var title: String
    var type: String
    var items: [PreferenceItem]
}

struct Recipe: Hashable, Identifiable, Codable {
    var id: String = "1"
    var title: String
    var rating: String
    var cookTime: String
    var difficulty: String
    var imageUrl: String
    var ingredients: [String]
    var link: String
}


class TopChoicesObserver : ObservableObject {
    init() { }
    init(queryString: String, queryType: String) {
        getTopChoices(queryString: queryString, queryType: queryType)
    }
    
    @Published var recipes = [Recipe]()
    @Published var category: String = ""
    @Published var title: String = ""
    @Published var item: String = ""
    @Published var subtitle: String = ""
    
    func clearTopChoices() {
        self.recipes = [Recipe]()
        self.category = ""
        self.title = ""
        self.item = ""
        self.subtitle = ""
    }

    func getTopChoices(queryString: String, queryType: String) {
        let parameters = [
            "user_id": UserDefaults.standard.string(forKey: "userID"),
            "query_type": queryType, //"ingredient",
            "query_string": queryString // "Chicken"
        ]
        Mixpanel.mainInstance().track(event: "Getting 1,2,3 Best", properties: ["Query Type" : queryType, "Query String": queryString])

        let headers : HTTPHeaders = ["Content-Type": "application/json"]
        AF.request("https://e2nmwaykqf.execute-api.us-west-1.amazonaws.com/alpha/cookingcardresults", method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                print(response)
            do {
                let json = try JSON(data: response.data ?? Data())
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





class Observer : ObservableObject{
    @Published var discoveryItems = [DiscoveryItem]()
    @Published var title: String = ""
    @Published var subtitle: String = ""
    
    init() {
        getSuggestions()
        getPreferences()
    }
    
    func getSuggestions() {
        let parameters = [
            "user_id": UserDefaults.standard.string(forKey: "userID"),
        ]
        let headers : HTTPHeaders = ["Content-Type": "application/json"]

        
        AF.request("https://e2nmwaykqf.execute-api.us-west-1.amazonaws.com/alpha/cookingcardsearch", method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
            do {
//                print(response)
                let json = try JSON(data: response.data ?? Data())
                if let title = json["title"].string {
                    self.title = title
                }
                if let subtitle = json["subtitle"].string {
                    self.subtitle = subtitle
                }
                
                for (i,subJson):(String, JSON) in json["data"]["items"] {
                    let item = DiscoveryItem(id: i, title: subJson["name"].stringValue, imageUrl: subJson["image"].stringValue, category: subJson["category"].stringValue, discover: subJson["discover"].boolValue, ideas: subJson["ideas"].boolValue)
                    self.discoveryItems.append(item)
                }
            } catch {
                print("error")
            }
        }
    }
    
    @Published var preferences = [Preference]()
    @Published var etching: String = ""
    @Published var userNumber: String = ""
    
    func getPreferences() {
        let parameters = ["user_id": UserDefaults.standard.string(forKey: "userID")]
        let headers : HTTPHeaders = ["Content-Type": "application/json"]
        AF.request("https://e2nmwaykqf.execute-api.us-west-1.amazonaws.com/alpha/preferencesget", method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
            do {
//                print(response)
                let json = try JSON(data: response.data ?? Data(), options: .allowFragments)
                if let etching = json["etching"].string {
                    self.etching = etching
                }
                if let userNumber = json["user_number"].string {
                    self.userNumber = userNumber
                }

                for (i,subJson):(String, JSON) in json["preferences"] {
                    var items = [PreferenceItem]()
                    for (j,item):(String, JSON) in subJson["items"] {
                        let prefItem = PreferenceItem(id: j, title: item["name"].stringValue, selected: item["selected"].boolValue)
                        items.append(prefItem)
                    }
                    let preference = Preference(id: i, title: subJson["title"].stringValue, type: subJson["type"].stringValue, items: items)
                    self.preferences.append(preference)
                }
            } catch {
                print("error")
            }
        }
    }

}
