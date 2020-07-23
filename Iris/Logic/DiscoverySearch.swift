//
//  DiscoverySearch.swift
//  Iris
//
//  Created by Shalin on 7/20/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct DiscoverySearch: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var searchPresented: Bool

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
            Search(isBack: true, placeholder: "Search for a cuisine, or an ingredient", searchText: $searchText, buttonCommit:{self.presentationMode.wrappedValue.dismiss()}).padding(.top, 40).background(Color.gray)
            
            HStack {
                if (self.searchText.isEmpty) {
                    Text("Suggestions for you").retinaTypography(.h5).padding(.leading, 24).padding(.top, 12).foregroundColor(.white)
                    Spacer()
                }
            }
            
            List {
                if (self.searchText.isEmpty) {
                    ForEach(self.discoveryItems, id: \.self) { item in
                        ZStack {
                            NavigationLink(
                              destination: TopChoicesView()) {
                                SearchCell(title: item.title, subtitle: item.category)
                                .listRowInsets(EdgeInsets())
                            }
                        }
                    }
                } else {
                    ForEach(self.allItems.filter {
                        self.searchText.isEmpty ? true : $0.title.lowercased().contains(self.searchText.lowercased())
                    }, id: \.self) { item in
                        ZStack {
                            NavigationLink(
                              destination: TopChoicesView()) {
                                SearchCell(title: item.title, subtitle: item.category)
                                .listRowInsets(EdgeInsets())
                            }
                        }
                    }
                }
            }.onAppear {
                UITableView.appearance().separatorStyle = .none
                UITableViewCell.appearance().backgroundColor = .black
                UITableView.appearance().backgroundColor = .black
                UITableViewCell.appearance().selectionStyle = .none
            }
            .buttonStyle(PlainButtonStyle())
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .resignKeyboardOnDragGesture()
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        .background(Color.black)
    }
}

struct DiscoverySearch_Previews: PreviewProvider {
    @State static var searchPresented = true

    static var previews: some View {
        DiscoverySearch(searchPresented: $searchPresented)
    }
}
