//
//  DrawerView.swift
//  Iris
//
//  Created by Shalin on 7/20/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

struct DrawerView<Content: View>: View {
    @Binding var isFull: Bool
    @State private var translation = CGSize.zero
    
    // The default color of back layer
    var backLayerColor = Color.black
    
    // The default opacity of back layer when the drawer is pulled out
    var backLayerOpacity = 0.0
    
    // Use the default animation of back layer
    var backLayerAnimation = Animation.default
        
    // The default height of drawer
    // Will be used when orientation set to be VERTICAL
    var drawerHeight: CGFloat?
    
    private var computedDrawerHeight: CGFloat {
        if let height = drawerHeight {
            return height
        }
        return (UIScreen.screenHeight / 5) * 3
    }
    
    private var computedDrawerFullHeight: CGFloat {
        if let height = drawerHeight {
            return height
        }
        return UIScreen.screenHeight
    }

    // The default value of corner radius of drawer view
    var drawerCornerRadius: CGFloat = 3
    
    // The default color of the background of drawer view
    var drawerBackgroundColor = Color.blue
    
    // The default animation of opening up drawer view
    var drawerOutAnimation = Animation.interpolatingSpring(mass: 0.5, stiffness: 45, damping: 45, initialVelocity: 15)
    
    var isDrawerShadowEnable = true
    
    var drawerShadowRadius: CGFloat = 20
    
    var content: Content
        
    private var initYOffset: CGFloat? {
        return isFull ?  0 : (UIScreen.screenHeight - computedDrawerHeight)
    }
    
    private var yOffset: CGFloat {
        if let y = initYOffset {
            return y + translation.height
        }
        return 0
    }
    
    var body: some View {
        ZStack {
            // Implement the darken background
            VStack {
                content
            }
            .frame(
                width: UIScreen.screenWidth,
                height: computedDrawerFullHeight)
            .background(drawerBackgroundColor)
            .cornerRadius(drawerCornerRadius)
            .shadow(radius: isDrawerShadowEnable ? drawerShadowRadius : 0)
            .offset(x: 0, y: yOffset)
            .animation(drawerOutAnimation)
        }
        .gesture(
            DragGesture()
                .onChanged { (value) in
                    if (self.isFull && value.translation.height > 0) {
                        self.translation = value.translation
                    }
                    if (!self.isFull && value.translation.height < 0) {
                        self.translation = value.translation
                    }
                }
                .onEnded { (value) in
                    print(value.location.y)

                    if self.isFull {
                        if value.translation.height > 30 {
                            self.isFull.toggle()
                        }
                    } else {
                        if value.translation.height < 30 {
                            self.isFull.toggle()
                        }
                    }
                    self.translation = CGSize.zero
                }
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct BottomDrawerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DrawerView(isFull: .constant(false), content: SampleDrawerInnerView())
                .previewDisplayName("Drawer is Half, Vertical")
            
            DrawerView(isFull: .constant(true), content: SampleDrawerInnerView())
                .previewDisplayName("Drawer is Full, Vertical")
        }
    }
}
