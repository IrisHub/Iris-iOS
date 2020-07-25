//
//  CollectionView.swift
//  Iris
//
//  Created by Shalin on 7/18/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct CollectionView<Content: View, Data: Hashable>: View {
    
    @Binding var data: [Data]
    let viewBuilder: (Data) -> Content
    let cols: Int
    let spacing: CGFloat
    
    let headerTop: String
    let headerMain: String
    let searchBarText: String
    
    @Binding var searchPresented: Bool
    @Binding var preferencesPresented: Bool

    
    @State private var showingPopupA = false


    init(data: Binding<[Data]>, cols: Int = 3, spacing: CGFloat = 5, searchPresented: Binding<Bool>, preferencesPresented: Binding<Bool>, _ viewBuilder: @escaping (Data) -> Content) {
        _data = data
        self.cols = cols
        self.spacing = spacing
        self.viewBuilder = viewBuilder
        self.headerTop = "Header Top"
        self.headerMain = "Main Title"
        self.searchBarText = "Search"
        _searchPresented = searchPresented
        _preferencesPresented = preferencesPresented
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                self.setupView(geometry: geometry).frame(minHeight: geometry.frame(in: .global).height)
            }
        }
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

        return VStack(alignment: .leading) {
            ZStack {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(headerTop)
                            .retinaTypography(.h4_main)
                            .padding([.leading], 24)
                        Spacer()
                        retinaIconButton(image: (Image(systemName: "line.horizontal.3.decrease")), action: { self.showingPopupA.toggle() })                            .padding([.trailing], 24)
                            .popover(isPresented: self.$showingPopupA) {
                                VStack {
                                    Button(action: {
                                        // Do something
                                        self.showingPopupA = false
                                    }) {
                                        Text("Option A")
                                    }
                                    Button(action: {
                                        // Do something
                                        self.showingPopupA = false
                                    }) {
                                        Text("Option B")
                                    }
                                }.background(Color.red)
                            }
                    }.frame(width: UIScreen.screenWidth, alignment: .leading).padding(.top, 84)

                    
                    Text(headerMain)
                        .retinaTypography(.h3_main)
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
                    if geometry.frame(in: .global).minY >= UIApplication.topInset {
                        ZStack {
                            // final - current / final
                            retinaSearchButton(text: self.searchBarText, color: .gray, backgroundColor: .white, action: { self.searchPresented.toggle() })
                                .offset(y: max(0, geometry.frame(in: .global).minY/9))
                        }
                    } else {
                        ZStack {
                            retinaSearchButton(text: "Text", color: .gray, backgroundColor: .white, action: { self.searchPresented.toggle() }).offset(y: -(geometry.frame(in: .global).minY - UIApplication.topInset))
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
                        self.cell(colIndex: col, rowIndex: row)
                        .frame(maxWidth: cellWidth)
                    }
                }.padding([.leading, .trailing, .top], 24)
            }
        }
    }


}

struct CollectionView_Previews: PreviewProvider {
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
            CollectionView(data: $data, cols: 2, spacing: -10, searchPresented: $searchPresented, preferencesPresented: $preferencesPresented) { item in
                // add cell content here
                DiscoveryCell(title: item.title, backgroundImageUrl: item.imageUrl).frame(width: 160, height: 100)
            }
            
            CollectionView(data: $colors, cols: 2, spacing: 20, searchPresented: $searchPresented, preferencesPresented: $preferencesPresented) { color in
                VStack {
                    Spacer()
                    Text(color.description)
                        .padding(10)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.white)
                }
                .frame(height: 120)
                .background(color)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.2), lineWidth: 1))
            }
            .padding()
            .background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.all))

        }
    }

}
