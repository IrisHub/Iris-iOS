//
//  DiscoveryView.swift
//  Iris
//
//  Created by Shalin on 7/18/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI


struct DiscoveryView: View {
    @State var discoveryItem: [DiscoveryItem]

    var body: some View {
        CollectionView(data: $discoveryItem, cols: 2, spacing: 24) { item in
            // add cell content here
            DiscoveryCell(title: item.title, backgroundImageUrl: item.imageUrl).frame(width: 160, height: 100)
        }
        .padding(24)
        .background(Color.black.opacity(0.05)
        .edgesIgnoringSafeArea(.all))
    }
}

struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryView(discoveryItem: [
            DiscoveryItem(title: "Chicken", imageUrl: "food"),
            DiscoveryItem(title: "Beef", imageUrl: "food"),
            DiscoveryItem(title: "Carrots", imageUrl: "food"),
            DiscoveryItem(title: "Broccoli", imageUrl: "food"),
            DiscoveryItem(title: "Pasta", imageUrl: "food"),
            DiscoveryItem(title: "Salmon", imageUrl: "food")
        ])
    }
}
