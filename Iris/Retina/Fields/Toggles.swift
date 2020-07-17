//
//  Toggles.swift
//  Iris
//
//  Created by Shalin on 7/17/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

public struct RetinaToggle: View {
    
    enum Style {
        case defaultStyle, primary, disabled, success, warning, danger, info
    }
    
    @State var toggleState: Bool = true
    var style: Style
    
    struct ColoredToggleStyle: ToggleStyle {
        var onColor = Color.retinaPrimary
        var offColor = Color.retinaDanger
        var thumbColor = Color.white
        
        func makeBody(configuration: Self.Configuration) -> some View {
            Button(action: { configuration.isOn.toggle() } ) {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 50, height: 29)
                    .overlay(
                        ZStack {
                            Circle()
                                .fill(thumbColor)
                                .shadow(radius: 1, x: 0, y: 1)
                                .padding(1.5)
                                .offset(x: configuration.isOn ? 10 : -10)
                            Image(systemName: configuration.isOn ? "checkmark" : "")
                                .font(.system(size: 12, weight: .black))
                                .foregroundColor(onColor)
                                .offset(x: configuration.isOn ? 10 : -10)
                            
                        }
                    )
                    .animation(.easeInOut(duration: 0.1))
            }
            .font(.title)
            .padding(.horizontal)
        }
    }
    
    
    public var body: some View {
        switch style {
        case .primary: return AnyView(primary())
        case .success: return AnyView(success())
        case .warning: return AnyView(warning())
        case .danger: return AnyView(danger())
        case .info: return AnyView(info())
        default: return AnyView(defaultStyle())
        }
    }
    
    
    fileprivate func defaultStyle() -> some View {
        Toggle("", isOn: $toggleState)
            .toggleStyle(
                ColoredToggleStyle(
                    onColor: .retinaBasic,
                    offColor: Color.retinaBasic.opacity(0.1),
                    thumbColor: .white))
    }
    
    fileprivate func primary() -> some View {
        Toggle("", isOn: $toggleState)
            .toggleStyle(
                ColoredToggleStyle(
                    onColor: .retinaPrimary,
                    offColor: Color.retinaPrimary.opacity(0.1),
                    thumbColor: .white))
    }
    
    fileprivate func success() -> some View {
        Toggle("", isOn: $toggleState)
            .toggleStyle(
                ColoredToggleStyle(
                    onColor: .retinaSuccess,
                    offColor: Color.retinaSuccess.opacity(0.1),
                    thumbColor: .white))
    }
    
    fileprivate func info() -> some View {
        Toggle("", isOn: $toggleState)
            .toggleStyle(
                ColoredToggleStyle(
                    onColor: .retinaInfo,
                    offColor: Color.retinaInfo.opacity(0.1),
                    thumbColor: .white))
    }
    
    
    fileprivate func warning() -> some View {
        Toggle("", isOn: $toggleState)
            .toggleStyle(
                ColoredToggleStyle(
                    onColor: .retinaWarning,
                    offColor: Color.retinaWarning.opacity(0.1),
                    thumbColor: .white))
    }
    
    
    fileprivate func danger() -> some View {
        Toggle("", isOn: $toggleState)
            .toggleStyle(
                ColoredToggleStyle(
                    onColor: .retinaDanger,
                    offColor: Color.retinaDanger.opacity(0.1),
                    thumbColor: .white))
    }
}

struct Toggles_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RetinaToggle(style: .defaultStyle)
            RetinaToggle(style: .primary)
            RetinaToggle(style: .success)
            RetinaToggle(style: .info)
            RetinaToggle(style: .warning)
            RetinaToggle(style: .danger)
        }
    }
}
