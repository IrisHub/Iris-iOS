//
//  WrapStack.swift
//  Iris
//
//  Created by Shalin on 7/18/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}


struct WrapStack: View {
    var strings: [String]

    @State var borderColor = Color.red
    @State var verticalAlignment = VerticalAlignment.top
    @State var horizontalAlignment = HorizontalAlignment.leading

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(self.strings.indices, id: \.self) {idx in
                    Text(self.strings[idx])
                        .position(self.nextPosition(
                            index: idx,
                            bucketRect: geometry.frame(in: .local)))
                }   //end GeometryReader
            }   //end ForEach
        }   //end ZStack
        .overlay(Rectangle().stroke(self.borderColor))
    }   //end body

    func nextPosition(index: Int,
                      bucketRect: CGRect) -> CGPoint {
        let ssfont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        let initX = (self.horizontalAlignment == .trailing) ? bucketRect.size.width : CGFloat(0)
        let initY = (self.verticalAlignment == .bottom) ? bucketRect.size.height : CGFloat(0)
        let dirX = (self.horizontalAlignment == .trailing) ? CGFloat(-1) : CGFloat(1)
        let dirY = (self.verticalAlignment == .bottom) ? CGFloat(-1) : CGFloat(1)

        let internalPad = 10   //fudge factor

        var runningX = initX
        var runningY = initY
        let fontHeight = "TEST".height(withConstrainedWidth: 30, font: ssfont)

        if index > 0 {
            for i in 0...index-1 {
                let w = self.strings[i].width(
                    withConstrainedHeight: fontHeight,
                    font: ssfont) + CGFloat(internalPad)
                if dirX <= 0 {
                    if (runningX - w) <= 0 {
                        runningX = initX - w
                        runningY = runningY + dirY * fontHeight
                    } else {
                        runningX -= w
                    }
                } else {
                    if (runningX + w) >= bucketRect.size.width {
                        runningX = initX + w
                        runningY = runningY + dirY * fontHeight
                    } else {
                        runningX += w
                    }   //end check if overflow
                }   //end check direction of flow
            }   //end for loop
        }   //end check if not the first one

        let w = self.strings[index].width(
            withConstrainedHeight: fontHeight,
            font: ssfont) + CGFloat(internalPad)

        if dirX <= 0 {
            if (runningX - w) <= 0 {
                runningX = initX
                runningY = runningY + dirY * fontHeight
            }
        } else {
            if (runningX +  w) >= bucketRect.size.width {
                runningX = initX
                runningY = runningY + dirY * fontHeight
            }  //end check if overflow
        }   //end check direction of flow

        //At this point runnoingX and runningY are pointing at the
        //corner of the spot at which to put this tag.  So...
        //
        return CGPoint(
            x: runningX + dirX * w/2,
            y: runningY + dirY * fontHeight/2)
    }

}   //end struct WrapStack

struct WrapStack_Previews: PreviewProvider {
    static var previews: some View {
        WrapStack(strings: ["One, ", "Two, ", "Three, ", "Four, ", "Five, ", "Six, ", "Seven, ", "Eight, ", "Nine, ", "Ten, ", "Eleven, ", "Twelve, ", "Thirteen, ", "Fourteen, ", "Fifteen, ", "Sixteen"])
    }
}
