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

    init(data: Binding<[Data]>, cols: Int = 3, spacing: CGFloat = 5,_ viewBuilder: @escaping (Data) -> Content) {
        _data = data
        self.cols = cols
        self.spacing = spacing
        self.viewBuilder = viewBuilder
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

        return VStack(alignment: .leading, spacing: spacing) {
            ForEach(0...rowCount-1, id: \.self) { row in
                HStack(spacing: self.spacing) {
                    ForEach(0...self.cols-1, id: \.self) { col in
                        self.cell(colIndex: col, rowIndex: row)
                        .frame(maxWidth: cellWidth)
                    }
                }
            }
            Spacer()
        }
    }


}

struct CollectionView_Previews: PreviewProvider {
    @State static var data = [
        DiscoveryItem(title: "Chicken", imageUrl: "food"),
        DiscoveryItem(title: "Beef", imageUrl: "food"),
        DiscoveryItem(title: "Carrots", imageUrl: "food"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food"),
        DiscoveryItem(title: "Pasta", imageUrl: "food"),
        DiscoveryItem(title: "Salmon", imageUrl: "food")
    ]
    @State static var colors: [Color] = [.pink, .red, .orange, .yellow, .green, .blue, .purple, .gray, .black]

    static var previews: some View {
        Group {
            CollectionView(data: $data, cols: 2, spacing: 24) { item in
                // add cell content here
                DiscoveryCell(title: item.title, backgroundImageUrl: item.imageUrl).frame(width: 160, height: 100)
            }
            
            CollectionView(data: $colors, cols: 2, spacing: 20) { color in
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
