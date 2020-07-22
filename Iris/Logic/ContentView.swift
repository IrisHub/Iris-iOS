//
//  ContentView.swift
//  Iris
//
//  Created by Shalin on 7/16/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct Card {
    var title: String
    var shortcuts: [String]
}

struct DiscoveryItem: Hashable {
    var title: String
    var imageUrl: String
    var category: String
}


//struct ContentView: View {
//    let settings: [String]
//    @State var selectedSettings: [String]
//
//    var body: some View {
//        List {
//            ForEach(settings, id: \.self) { item in
//                SelectionCell(title: item, selectedTitles: self.$selectedSettings, isSingleSelect: true)
//            }
//        }
//    }
//
//}
//
//struct ContentView_Previews: PreviewProvider {
//    @State static var settings = ["pEars", "apples"]
//    static var previews: some View {
//        ContentView(settings: ["apples", "pears", "bananas", "pineapples"], selectedSettings: settings)
//    }
//}

struct ContentView: View {
    @State var isFull = false
    
    var body: some View {
        NavigationView {
            DiscoveryView(discoveryItem: [
                DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
                DiscoveryItem(title: "Salmon", imageUrl: "food", category: "Ingredient")
            ])
//            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           ContentView()
              .environment(\.colorScheme, .light)

           ContentView()
              .environment(\.colorScheme, .dark)
        }
    }
}
