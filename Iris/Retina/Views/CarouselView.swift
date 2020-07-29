//
//  CarouselView.swift
//  Iris
//
//  Created by Shalin on 7/21/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct CarouselView: View
{
    var UIState: UIStateModel
    @State private var showingAlert = false
    @Binding var showBanner : Bool
    @Binding var recipePresented : Bool
    @Binding var selectedChoice: Int
    @ObservedObject var observed: TopChoicesObserver
    
    var body: some View
    {
        let spacing:            CGFloat = 20
        let widthOfHiddenCards: CGFloat = 10    // UIScreen.main.bounds.width - 10
        let cardHeight:         CGFloat = 400

        var items: [HomeCell] = [HomeCell]()
        for idx in 0..<self.observed.recipes.count {
            items.append(HomeCell(id: idx, recipe: self.observed.recipes[idx], recipePresented: self.$recipePresented, selectedChoice: self.$selectedChoice))
        }
        
        return  Canvas
                {
                    Carousel( numberOfItems: CGFloat( items.count ), spacing: spacing, widthOfHiddenCards: widthOfHiddenCards )
                    {
                        ForEach( items, id: \.self.id ) { item in
                            Item( _id:                  Int(item.id),
                                  spacing:              spacing,
                                  widthOfHiddenCards:   widthOfHiddenCards,
                                  cardHeight:           cardHeight )
                            {
                                item
                                .highPriorityGesture(LongPressGesture(minimumDuration: 0.5)
                                .onEnded { _ in
                                    self.showingAlert = true
                                })
                                .alert(isPresented: self.$showingAlert) {
                                    Alert(title: Text("Was this recipe helpful?"), message: Text(""), primaryButton: .default(Text("Not Helpful"), action: {
                                        self.showBanner = true
                                    }), secondaryButton: .default(Text("Cancel")))
                                }
                            }
                            .transition( AnyTransition.slide )
                            .animation( .spring() )
                        }
                    }
                    .environmentObject( self.UIState )
                }
    }
}


public class UIStateModel: ObservableObject
{
    @Published var activeCard: Int      = 0
    @Published var screenDrag: Float    = 0.0
}



struct Carousel<Items : View> : View {
    let items: Items
    let numberOfItems: CGFloat //= 8
    let spacing: CGFloat //= 16
    let widthOfHiddenCards: CGFloat //= 32
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDetectingLongPress = false
    
    @EnvironmentObject var UIState: UIStateModel
        
    @inlinable public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        @ViewBuilder _ items: () -> Items) {
        
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        
    }
    
    var body: some View {
        
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing

        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard) + 1)

        var calcOffset = Float(activeOffset)

        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + UIState.screenDrag
        }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset), y: 0)
        .highPriorityGesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
            self.UIState.screenDrag = Float(currentState.translation.width)

        }.onEnded { value in
            self.UIState.screenDrag = 0

            if (value.translation.width < -50 && CGFloat(self.UIState.activeCard) < self.numberOfItems - 1) {
                self.UIState.activeCard = self.UIState.activeCard + 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }

            if (value.translation.width > 50 && CGFloat(self.UIState.activeCard) > 0) {
                self.UIState.activeCard = self.UIState.activeCard - 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
        })
    }
}



struct Canvas<Content : View> : View {
    let content: Content
    @EnvironmentObject var UIState: UIStateModel
    
    @inlinable init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.retinaBase.edgesIgnoringSafeArea(.all))
    }
}



struct Item<Content: View>: View {
    @EnvironmentObject var UIState: UIStateModel
    let cardWidth: CGFloat
    let cardHeight: CGFloat

    var _id: Int
    var content: Content

    @inlinable public init(
        _id: Int,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        cardHeight: CGFloat,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        self.cardHeight = cardHeight
        self._id = _id
    }

    var body: some View {
        content
            .frame(width: cardWidth, height: _id == UIState.activeCard ? cardHeight : cardHeight - 60, alignment: .center)
    }
}

//struct CarouselView_Previews: PreviewProvider {
//    static var state: UIStateModel = UIStateModel()
//    @State static var recipePresented: Bool = false
//    @State static var showBanner:Bool = false
//    static var previews: some View {
//        // Create the SwiftUI view that provides the window contents.
//        CarouselView(UIState: state, showBanner: $showBanner, recipePresented: $recipePresented, observed: <#Observer#>)
//    }
//}
