//
//  Search.swift
//  Iris
//
//  Created by Shalin on 7/19/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct Search: View {
    @Binding var searchText: String
    @Binding var showCancelButton: Bool

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                    self.showCancelButton = true
                }, onCommit: {
                    print("onCommit")
                }).foregroundColor(.primary)

                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)

            if showCancelButton  {
                Button("Cancel") {
                        UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                        self.searchText = ""
                        self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton) // .animation(.default) // animation does not work properly
    }
}

struct Search_Previews: PreviewProvider {
    @State static var searchTextEmpty = ""
    @State static var dontShowCancelButton = false
    @State static var searchTextFilled = "Hi Friends"
    @State static var showCancelButton = true
    
    static var previews: some View {
        Group {
            Search(searchText: $searchTextEmpty, showCancelButton: $dontShowCancelButton)
            Search(searchText: $searchTextFilled, showCancelButton: $showCancelButton)
        }
    }
}
