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

    var body: some View {
        VStack {
            HStack {
                HStack {
                    if (isBack) {
                        
                    }
                    Image(systemName: isBack ? "chevron.left" : "magnifyingglass").padding(6).padding(.leading, 12).retinaTypography(.h5)
                    
                    ZStack(alignment: .leading) {
                        if searchText.isEmpty { Text(placeholder).foregroundColor(.white).retinaTypography(.p5).padding(.leading, 12) }
                        TextField("", text: $searchText).retinaTypography(.p5).padding(.leading, 12)
                    }
                    

                    Button(action: {
                        self.searchText = ""
                        UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                    }.padding(6).padding(.trailing, 12)
                }.frame(minHeight: 56)
                    .foregroundColor(.white)
                    .background(Color(.gray))
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
            Search(isBack: true, placeholder: "Search", searchText: $searchTextEmpty)
            Search(isBack: true, placeholder: "Search", searchText: $searchTextFilled)
        }
    }
}
