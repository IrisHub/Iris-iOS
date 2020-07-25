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
        case .outlineOnly: return AnyView(OutlineOnlyButton(color: color, configuration: configuration))
        case .ghost: return AnyView(GhostButton(color: color, configuration: configuration))
        case .search: return AnyView(SearchButton(color: color, configuration: configuration))
        }
    }
    
    struct SearchButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .retinaTypography(.h6_main)
                .foregroundColor(isEnabled ? .white : .retinaOverlayDark)
                .padding([.leading, .trailing])
                .frame(minHeight: 36)
                .background(isEnabled ? color : Color.retinaBase.opacity(0.2))
                .cornerRadius(4)
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }

    
    struct FillButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .retinaTypography(.p5_main)
                .foregroundColor(isEnabled ? .white : .retinaBase)
                .padding()
                .frame(minHeight: 56)
                .background(isEnabled ? color : Color.retinaBase.opacity(0.2))
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
                .retinaTypography(.p5_main)
                .foregroundColor(isEnabled ? color : .retinaBase)
                .padding()
                .frame(minHeight: 56)
                .background(isEnabled ? color.opacity(0.2) : Color.retinaBase.opacity(0.15))
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(isEnabled ? color : Color.retinaBase.opacity(0.5), lineWidth: 1)
                )
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
    
    struct OutlineOnlyButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .retinaTypography(.h5_main)
                .foregroundColor(isEnabled ? color : .retinaBase)
                .padding(12)
                .frame(minHeight: 56)
                .background(Color.clear)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(isEnabled ? color : Color.retinaBase.opacity(0.5), lineWidth: 2)
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
                .retinaTypography(.p5_main)
                .foregroundColor(isEnabled ? color : .retinaBase)
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
        case fill, outline, outlineOnly, ghost, search
    }
    
    var text: String?
    var image: Image?
    var style: Style = .fill
    var color: Color = .retinaBase
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

struct retinaSearchButton: View {
    var text: String?
    var color: Color = .retinaOverlayDark
    var backgroundColor: Color = .retinaOverflow
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button(action: action, label: {
                HStack() {
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass").padding(6).foreground(Color.retinaPink)
                        Text(text ?? "").retinaTypography(.p6_main)
                    }
                    Spacer()
                }
            }).style(.search, color: color).padding([.leading, .trailing], 24)
        }.frame(width: UIScreen.screenWidth, height: 90).background(backgroundColor)
    }
}


struct retinaIconButton: View {
    enum Style {
        case fill, outline, ghost
    }

    var image: Image?
    var backgroundColor: Color = .black
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button(action: action, label: {
                image?.foregroundColor(.white).retinaTypography(.h5_main)
            })
        }
        .frame(width: 48, height: 48)
        .background(backgroundColor.opacity(0.8))
        .cornerRadius(2)
    }
}




// MARK: - Preview

public struct Input_Previews: PreviewProvider {
    static let cloudImg = Image(systemName: "cloud.sun")
    
    public static var previews: some View {
        VStack(spacing: 40) {
            
            HStack(spacing: 5) {
                retinaButton(text: "Fill", style: .fill, action: { print("click") })
                retinaButton(text: "Outline", style: .outline, color: .retinaBase, action: { print("click") })
                retinaButton(text: "Ghost", style: .ghost, action: { print("click") })
            }
            
            HStack(spacing: 5) {
                retinaButton(text: "Danger", color: .retinaBase, action: { print("click") })
                retinaButton(text: "Warning", color: .retinaBase, action: { print("click") })
                retinaButton(text: "Success", color: .retinaBase, action: { print("click") })
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
            
            HStack(spacing: 5) {
                retinaSearchButton(text: "Text", action: { print("click") })
            }
            
            HStack(spacing: 5) {
                retinaIconButton(image: (Image(systemName: "line.horizontal.3.decrease")), action: { print("click") })
            }

            
            Button(action: { print("click") }, label: { Text("Custom") })
                .style(.outline, color: .retinaBase)
        }
    .padding(10)
    }
}
