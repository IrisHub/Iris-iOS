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

struct ContentView: View {
    @State var searchPresented = false
    @State var preferencesPresented = false
    @State var discoveryItem: [DiscoveryItem]

    var body: some View {
        ZStack {
            NavigationView {
                
                if(searchPresented){
                    NavigationLink(destination: DiscoverySearch(searchPresented: self.$searchPresented), isActive: $searchPresented) {
                        DiscoverySearch(searchPresented: self.$searchPresented)
                    }.hidden()
                }else{
                        CollectionView(data: $discoveryItem, cols: 2, spacing: 24, searchPresented: $searchPresented, preferencesPresented: $preferencesPresented) { item in
                            // add cell content here
                            NavigationLink(
                              destination: TopChoicesView()) {
                                DiscoveryCell(title: item.title, backgroundImageUrl: item.imageUrl)
                            }.buttonStyle(PlainButtonStyle())
                        }
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    }
                }

                
                        
//            DiscoverySearch(searchPresented: self.$searchPresented).offset(y: searchPresented ? 0 : 1000)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(discoveryItem: [
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
              .environment(\.colorScheme, .light)
        }
    }
}
