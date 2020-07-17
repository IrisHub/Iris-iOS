//
//  Button.swift
//  Iris
//
//  Created by Shalin on 7/17/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

// MARK: - Custom Button Styles

struct RetinaButtonStyle: ButtonStyle {
    var color: Color
    var style: retinaButton.Style
    
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        switch style {
        case .fill: return AnyView(FillButton(color: color, configuration: configuration))
        case .outline: return AnyView(OutlineButton(color: color, configuration: configuration))
        case .ghost: return AnyView(GhostButton(color: color, configuration: configuration))
        }
    }
    
    struct FillButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .retinaTypography(.s1)
                .foregroundColor(isEnabled ? .white : .retinaFontDisabled)
                .padding()
                .frame(minHeight: 56)
                .background(isEnabled ? color : Color.retinaBasic.opacity(0.2))
                .cornerRadius(4)
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
    
    struct OutlineButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .retinaTypography(.s1)
                .foregroundColor(isEnabled ? color : .retinaFontDisabled)
                .padding()
                .frame(minHeight: 56)
                .background(isEnabled ? color.opacity(0.2) : Color.retinaBasic.opacity(0.15))
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(isEnabled ? color : Color.retinaBasic.opacity(0.5), lineWidth: 1)
                )
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
    
    struct GhostButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .retinaTypography(.s1)
                .foregroundColor(isEnabled ? color : .retinaFontDisabled)
                .padding()
                .frame(minHeight: 56)
                .background(Color.white)
                .cornerRadius(4)
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
}

// MARK: - Usage

extension Button {
    /// Changes the appearance of the button
    func style(_ style: retinaButton.Style, color: Color) -> some View {
        self.buttonStyle(RetinaButtonStyle(color: color, style: style))
    }
}

struct retinaButton: View {
    
    enum Style {
        case fill, outline, ghost
    }
    
    var text: String?
    var image: Image?
    var style: Style = .fill
    var color: Color = .retinaPrimary
    var action: () -> Void
    var textAndImage: Bool { text != nil && image != nil }
    
    var body: some View {
        Button(action: action, label: {
            HStack() {
                Spacer()
                HStack(spacing: textAndImage ? 12 : 0) {
                    Text(text ?? "")
                    image
                }
                Spacer()
            }
        }).style(style, color: color)
    }
}


// MARK: - Preview

public struct Input_Previews: PreviewProvider {
    static let cloudImg = Image(systemName: "cloud.sun")
    
    public static var previews: some View {
        VStack(spacing: 40) {
            
            HStack(spacing: 5) {
                retinaButton(text: "Fill", style: .fill, action: { print("click") })
                retinaButton(text: "Outline", style: .outline, action: { print("click") })
                retinaButton(text: "Ghost", style: .ghost, action: { print("click") })
            }
            
            HStack(spacing: 5) {
                retinaButton(text: "Danger", color: .retinaDanger, action: { print("click") })
                retinaButton(text: "Warning", color: .retinaWarning, action: { print("click") })
                retinaButton(text: "Success", color: .retinaSuccess, action: { print("click") })
            }
            
            HStack(spacing: 5) {
                retinaButton(text: "Disabled", style: .fill, action: { print("click") })
                    .disabled(true)
                retinaButton(text: "Disabled", style: .outline, action: { print("click") })
                    .disabled(true)
                retinaButton(text: "Disabled", style: .ghost, action: { print("click") })
                    .disabled(true)
            }
            
            HStack(spacing: 5) {
                retinaButton(text: "Text", action: { print("click") })
                retinaButton(text: "Text", image: cloudImg, action: { print("click") })
                retinaButton(image: cloudImg, action: { print("click") })
            }
            
            Button(action: { print("click") }, label: { Text("Custom") })
                .style(.outline, color: .retinaFontBtn)
        }
    .padding(10)
    }
}
