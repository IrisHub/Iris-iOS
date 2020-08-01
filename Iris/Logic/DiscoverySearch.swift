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
    @ObservedObject var observed: Observer
    @ObservedObject var observedTopChoices: TopChoicesObserver
    @State private var searchText = ""
//    @State var topChoicesPresented: Bool = false

    var body: some View {
        VStack {
            // Search bar
            Search(isBack: true, placeholder: "Try a cuisine, ingredient, or dish", searchText: $searchText, buttonCommit:{ self.presentationMode.wrappedValue.dismiss() }).padding(.top, 40).background(Color.retinaOverlayLight)
            
            HStack {
                if (self.searchText.isEmpty) {
                    Text("Suggestions for you").retinaTypography(.p5_main).padding(.leading, 24).padding(.top, 12).foregroundColor(.retinaWinterGrey)
                    Spacer()
                }
            }
            
            ScrollView(.vertical) {
                if (self.searchText.isEmpty) {
                    ForEach(self.observed.discoveryItems.filter {
                        $0.ideas == true
                    }, id: \.self) { item in
                        NavigationLink(
                        destination: LazyView(TopChoicesView(observed: self.observedTopChoices))) {
                            SearchCell(title: item.title, subtitle: item.category)
                            .listRowInsets(EdgeInsets())
                        }
                    }
                } else {
                    if self.observed.discoveryItems.filter { $0.title.lowercased().contains(self.searchText.lowercased()) }.count == 0 {
                        Text("No search results found, sorry.").retinaTypography(.p5_main).padding(.top, 36).foregroundColor(.retinaWinterGrey)
                    } else {
                        ForEach(self.observed.discoveryItems.filter {
                            self.searchText.isEmpty ? true : $0.title.lowercased().contains(self.searchText.lowercased())
                        }, id: \.self) { item in
                            NavigationLink(
                            destination: LazyView(TopChoicesView(observed: self.observedTopChoices))) {
                                SearchCell(title: item.title, subtitle: item.category)
                                .listRowInsets(EdgeInsets())

                            }
                        }
                    }
                }
            }.padding([.bottom], UIApplication.bottomInset).background(Color.retinaOverflow).edgesIgnoringSafeArea(.bottom)
            .onAppear {
                UITableView.appearance().separatorStyle = .none
                UITableViewCell.appearance().backgroundColor = Color.retinaOverflow.uiColor()
                UITableView.appearance().backgroundColor = Color.retinaOverflow.uiColor()
                UITableViewCell.appearance().selectionStyle = .none
            }
            .resignKeyboardOnDragGesture()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        .background(Color.retinaOverflow)
    }
}

struct DiscoverySearch_Previews: PreviewProvider {
    @ObservedObject static var observed = Observer()
    @ObservedObject static var observedTopChoices = TopChoicesObserver()

    static var previews: some View {
        DiscoverySearch(observed: observed, observedTopChoices: observedTopChoices)
    }
}
