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

struct ContentView<Content: View>: View {
    var data: [DiscoveryItem]
    let viewBuilder: (DiscoveryItem) -> Content
    let cols: Int
    let spacing: CGFloat
    
    let headerTop: String
    let headerMain: String
    let searchBarText: String
    
    @State var searchPresented: Bool = false
    @State var preferencesPresented: Bool = false

    init(data: [DiscoveryItem], cols: Int = 3, spacing: CGFloat = 5, _ viewBuilder: @escaping (DiscoveryItem) -> Content) {
        self.cols = cols
        self.spacing = spacing
        self.viewBuilder = viewBuilder
        self.headerTop = "Header Top"
        self.headerMain = "Main Title"
        self.searchBarText = "Search"
        self.data = data
    }

    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader { geometry in
                    ScrollView {
                        self.setupView(geometry: geometry).frame(minHeight: geometry.frame(in: .global).height)
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
        .overlay(self.preferencesPresented ? PreferencesView(titles: ["Diet", "Food I don’t eat", "Time I have to cook Lunch", "Time I have to cook Dinner", "My cooking level", "Spice Tolerance", "See meals that are", "Top Cuisines"], settings: ["Vegan", "Eggs", "30min", "1 hour", "Intermediate", "Low", "Healthy", "American"], preferencesPresented: $preferencesPresented) : nil)


    }
    
    private func cell(colIndex: Int, rowIndex: Int) -> some View {
        let cellIndex = (rowIndex * cols) + colIndex
        return ZStack {
            if cellIndex < data.count {
                self.viewBuilder(data[cellIndex])
            }
        }
    }

    private func setupView(geometry: GeometryProxy) -> some View {
        let rowRemainder = Double(data.count).remainder(dividingBy: Double(cols))
        let rowCount = data.count / cols + (rowRemainder == 0 ? 0 : 1)
        let frame = geometry.frame(in: .global)
        let totalSpacing = Int(spacing) * (cols - 1)
        let cellWidth = (frame.width - CGFloat(totalSpacing))/CGFloat(cols)

        return

            VStack(alignment: .leading) {
            ZStack {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(headerTop)
                            .retinaTypography(.h4)
                            .padding([.leading], 24)
                        Spacer()
                        retinaIconButton(image: (Image(systemName: "line.horizontal.3.decrease")), action: { self.preferencesPresented.toggle() })                            .padding([.trailing], 24)
                    }.frame(width: UIScreen.screenWidth, alignment: .leading).padding(.top, 84)
                    
                    Text(headerMain)
                        .retinaTypography(.h3)
                        .padding([.leading], 24)
                        .frame(width: UIScreen.screenWidth, alignment: .leading)
                }
                GeometryReader { geometry in
                    Rectangle().offset(y: -(geometry.frame(in: .global).minY)).foregroundColor(.white)
                    .blur(radius: 20)
                    .padding(-25)
                        .frame(width: UIScreen.screenWidth, height: UIApplication.topInset*1.5)
                }
            }.zIndex(1)
            

            
            // Search view
            GeometryReader { geometry in
                VStack {
                    NavigationLink(destination: DiscoverySearch(searchPresented: self.$searchPresented), isActive: self.$searchPresented) { EmptyView() }
                    if geometry.frame(in: .global).minY >= UIApplication.topInset {
                        ZStack {
                            retinaSearchButton(text: self.searchBarText, color: .gray, backgroundColor: .white, action: { self.searchPresented = true })
                                .offset(y: max(0, geometry.frame(in: .global).minY/9))
                        }
                    } else {
                        ZStack {
                            retinaSearchButton(text: "Text", color: .gray, backgroundColor: .white, action: { self.searchPresented = true }).offset(y: -(geometry.frame(in: .global).minY - UIApplication.topInset))
                        }
                    }
                }
            }.frame(height: 60)
            .zIndex(1)
            .padding(.bottom, 24)
            .padding(.top, 100)

            ForEach(0...rowCount-1, id: \.self) { row in
                HStack() {
                    ForEach(0...self.cols-1, id: \.self) { col in
                        NavigationLink(
                          destination: TopChoicesView()) {
                            self.cell(colIndex: col, rowIndex: row)
                            .frame(maxWidth: cellWidth)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }.padding([.leading, .trailing, .top], 24)
            }
        }
    }
}























struct ContentView_Previews: PreviewProvider {
    
    @State static var data = [
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Salmon", imageUrl: "food", category: "Ingredient")
    ]
    @State static var colors: [Color] = [.pink, .red, .orange, .yellow, .green, .blue, .purple, .gray, .black]
    
    @State static var searchPresented = false
    @State static var preferencesPresented = false

    static var previews: some View {
        Group {
            ContentView(data: data, cols: 2, spacing: -10) { item in
                // add cell content here
                DiscoveryCell(title: item.title, backgroundImageUrl: item.imageUrl).frame(width: 160, height: 100)
            }
        }
    }
}



