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
    let array = ["Peter", "Paul", "Mary", "Anna-Lena", "George", "John", "Greg", "Thomas", "Robert", "Bernie", "Mike", "Benno", "Hugo", "Miles", "Michael", "Mikel", "Tim", "Tom", "Lottie", "Lorrie", "Barbara"]
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false

    var body: some View {

        NavigationView {
            VStack(alignment: .leading) {
                Text("For you")
                    .retinaTypography(.h4)
                    .padding(.leading, 24)
                    .padding(.top, 48)
                
                Text("Dinner, 7PM")
                    .retinaTypography(.h3)
                    .padding(.leading, 24)
                    .padding(.top, 12)
                
                ZStack(alignment: .top) {
                    Rectangle().frame(width: UIScreen.screenWidth-48, height: 36)
                        .cornerRadius(2)
                        .border(Color.retinaBasic)
                        .foregroundColor(Color.clear)
                        .padding([.leading, .bottom], 24)
                    
                    HStack() {
                        Image(systemName: "checkmark")
                        Text("For you")
                            .retinaTypography(.p6)
                            .padding(.leading, 24)
                        Text("For you")
                            .retinaTypography(.p6)
                            .padding(.leading, 24)
                        Text("For you")
                            .retinaTypography(.p6)
                            .padding(.leading, 24)
                    }.padding(10)
                }

                
                // Search view
                Search(searchText: $searchText, showCancelButton: $showCancelButton)

                List {
                    // Filtered list of names
                    ForEach(array.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
                        searchText in Text(searchText)
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .resignKeyboardOnDragGesture()
            }
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
