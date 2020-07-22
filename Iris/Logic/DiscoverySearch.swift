//
//  DiscoverySearch.swift
//  Iris
//
//  Created by Shalin on 7/20/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct DiscoverySearch: View {
    let discoveryItems = [
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Salmon", imageUrl: "food", category: "Ingredient")
    ]
    
    let allItems = [
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Salmon", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Salmon", imageUrl: "food", category: "Ingredient")
    ]

    
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            // Search bar
            Search(isBack: true, placeholder: "Search for a cuisine, or an ingredient", searchText: $searchText).padding(.top, 40).background(Color.gray)
            
            HStack {
                if (self.searchText.isEmpty) {
                    Text("Suggestions for you").retinaTypography(.h5).padding(.leading, 24).padding(.top, 12).foregroundColor(.white)
                    Spacer()
                }
            }
            
            List {
                if (self.searchText.isEmpty) {
                    ForEach(self.discoveryItems, id: \.self) { item in
                        SearchCell(title: item.title, subtitle: item.category)
                        .listRowInsets(EdgeInsets())
                    }
                } else {
                    ForEach(self.allItems.filter {
                        self.searchText.isEmpty ? true : $0.title.lowercased().contains(self.searchText.lowercased())
                    }, id: \.self) { item in
                        SearchCell(title: item.title, subtitle: item.category)
                        .listRowInsets(EdgeInsets())
                    }
                }
            }.onAppear {
                UITableView.appearance().separatorStyle = .none
                UITableViewCell.appearance().backgroundColor = .black
                UITableView.appearance().backgroundColor = .black
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .resignKeyboardOnDragGesture()
            
        }.edgesIgnoringSafeArea(.top).background(Color.black)
    }
}

struct DiscoverySearch_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverySearch()
    }
}
