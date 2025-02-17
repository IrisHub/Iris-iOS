//
//  Search.swift
//  Iris
//
//  Created by Shalin on 7/19/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct Search: View {
    var isBack: Bool
    var placeholder: String
    @Binding var searchText: String
    var buttonCommit: () -> Void = {}

    var body: some View {
        VStack {
            HStack {
                HStack {
                    Button(action: {
                        UIApplication.shared.endEditing(true)
                        self.searchText = ""
                        self.buttonCommit()
                    }) {
                        Image(systemName: isBack ? "chevron.left" : "magnifyingglass")
                        .retinaTypography(.h5_main)
                        .foregroundColor(.retinaPink)
                    }.padding(6).padding(.leading, 12)

                                        
                    ZStack(alignment: .leading) {
                        if searchText.isEmpty { Text(placeholder).foregroundColor(.retinaSnowWhite).retinaTypography(.p6_main).padding(.leading, 12) }
                        TextField("", text: $searchText).retinaTypography(.p6_main).padding(.leading, 12)
                    }
                    

                    Button(action: {
                        UIApplication.shared.endEditing(true)
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                    }.padding(6).padding(.trailing, 12)
                }.frame(minHeight: 36)
                    .foregroundColor(.retinaSnowWhite)
                    .background(Color.retinaOverlayDark)
                    .cornerRadius(4)
                    .padding([.leading, .trailing], 24)

            }
            .frame(width: UIScreen.screenWidth, height: 90)
        }
        

    }
}

struct Search_Previews: PreviewProvider {
    @State static var searchTextEmpty = ""
    @State static var searchTextFilled = "Hi Friends"
    
    static var previews: some View {
        Group {
            HStack {
                retinaSearchButton(text: "Hello", color: .gray, backgroundColor: .white, action: { print("click") })
            }
            Search(isBack: true, placeholder: "Try a cuisine, ingredient, or dish", searchText: $searchTextEmpty, buttonCommit:{})
            Search(isBack: true, placeholder: "Try a cuisine, ingredient, or dish", searchText: $searchTextFilled, buttonCommit:{})
        }
    }
}
