//
//  TextFields.swift
//  Iris
//
//  Created by Shalin on 7/17/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI

public struct RetinaTextField: View {
    
    enum Style {
        case defaultStyle, primary, disabled, success, warning, danger, info
    }
    
    var style: Style
    var placeholder: String
    var icon: Image? = nil
    var commit: ()->() = { }
    @State private var focused: Bool = false
    @State var input: String = ""
    
    // MARK: Inits
    
    init(_ placeholder: String, onCommit: @escaping ()->() = { }) {
        self.placeholder = placeholder
        self.style = .defaultStyle
        self.commit = onCommit
    }
    
    init(_ placeholder: String, style: Style, onCommit: @escaping ()->() = { }) {
        self.placeholder = placeholder
        self.style = style
        self.commit = onCommit
    }
    
    init(_ placeholder: String, icon: Image, onCommit: @escaping ()->() = { }) {
        self.placeholder = placeholder
        self.icon = icon
        self.style = .defaultStyle
        self.commit = onCommit
    }
    
    init(_ placeholder: String, style: Style, icon: Image, onCommit: @escaping ()->() = { }) {
        self.placeholder = placeholder
        self.style = style
        self.icon = icon
        self.commit = onCommit
    }
    
    // MARK:  Function declarations
    
    fileprivate func defaultStyle() -> some View {
        HStack {
            ZStack(alignment: .leading) {
                if input.isEmpty { Text(placeholder).foregroundColor(.retinaBasic) }
                TextField("", text: $input, onEditingChanged: { editingChanged in
                    self.focused = editingChanged
                    print(editingChanged ? "TextField focused" : "TextField focus removed")
                }, onCommit: commit).foregroundColor(.retinaFontStd)
            }
            if focused { icon.imageScale(.large).foregroundColor(.retinaPrimary) }
            else { icon.imageScale(.large).foregroundColor(.retinaBasic) }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 5)
        .foregroundColor(Color.retinaBasic.opacity(self.focused ? 0 : 0.1)))
        .overlay(RoundedRectangle(cornerRadius: 5)
        .stroke(self.focused ? Color.retinaPrimary : Color.retinaBasic.opacity(0.4), lineWidth: 1))
    }
    
    fileprivate func primary() -> some View {
        HStack {
            ZStack(alignment: .leading) {
                if input.isEmpty { Text(placeholder).foregroundColor(.retinaPrimary) }
                TextField("", text: $input, onEditingChanged: { editingChanged in
                    self.focused = editingChanged
                    print(editingChanged ? "TextField focused" : "TextField focus removed")
                }, onCommit: commit).foregroundColor(.retinaFontStd)
            }
             icon.imageScale(.large).foregroundColor(.retinaPrimary)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 5)
        .foregroundColor(Color.retinaBasic.opacity(self.focused ? 0 : 0.1)))
        .overlay(RoundedRectangle(cornerRadius: 5)
        .stroke(Color.retinaPrimary, lineWidth: 1))
    }
    
    fileprivate func success() -> some View {
        HStack {
            ZStack(alignment: .leading) {
                if input.isEmpty { Text(placeholder).foregroundColor(.retinaBasic) }
                TextField("", text: $input, onEditingChanged: { editingChanged in
                    self.focused = editingChanged
                    print(editingChanged ? "TextField focused" : "TextField focus removed")
                }, onCommit: commit).foregroundColor(.retinaFontStd)
            }
            icon.imageScale(.large).foregroundColor(.retinaSuccess)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 5)
        .foregroundColor(Color.retinaBasic.opacity(self.focused ? 0 : 0.1)))
        .overlay(RoundedRectangle(cornerRadius: 5)
        .stroke(Color.retinaSuccess, lineWidth: 1))
    }
    
    fileprivate func warning() -> some View {
        HStack {
            ZStack(alignment: .leading) {
                if input.isEmpty { Text(placeholder).foregroundColor(Color.retinaBasic) }
                TextField("", text: $input, onEditingChanged: { editingChanged in
                    self.focused = editingChanged
                    print(editingChanged ? "TextField focused" : "TextField focus removed")
                }, onCommit: commit).foregroundColor(.retinaFontStd)
            }
            icon.imageScale(.large).foregroundColor(.retinaWarning)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 5)
        .foregroundColor(Color.retinaBasic.opacity(self.focused ? 0 : 0.1)))
        .overlay(RoundedRectangle(cornerRadius: 5)
        .stroke(Color.retinaWarning, lineWidth: 1))
    }
    
    fileprivate func danger() -> some View {
        HStack {
            ZStack(alignment: .leading) {
                if input.isEmpty { Text(placeholder).foregroundColor(.retinaBasic) }
                TextField("", text: $input, onEditingChanged: { editingChanged in
                    self.focused = editingChanged
                    print(editingChanged ? "TextField focused" : "TextField focus removed")
                }, onCommit: commit).foregroundColor(.retinaFontStd)
            }
            icon.imageScale(.large).foregroundColor(.retinaDanger)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 5)
        .foregroundColor(Color.retinaBasic.opacity(self.focused ? 0 : 0.1)))
        .overlay(RoundedRectangle(cornerRadius: 5)
        .stroke(Color.retinaDanger, lineWidth: 1))
    }
    
    fileprivate func info() -> some View {
        HStack {
            ZStack(alignment: .leading) {
                if input.isEmpty { Text(placeholder).foregroundColor(.retinaBasic) }
                TextField("", text: $input, onEditingChanged: { editingChanged in
                    self.focused = editingChanged
                    print(editingChanged ? "TextField focused" : "TextField focus removed")
                }, onCommit: commit).foregroundColor(.retinaFontStd)
            }
            icon.imageScale(.large).foregroundColor(.retinaInfo)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 5)
        .foregroundColor(Color.retinaBasic.opacity(self.focused ? 0 : 0.1)))
        .overlay(RoundedRectangle(cornerRadius: 5)
        .stroke(Color.retinaInfo, lineWidth: 1))
    }
    
    // MARK:  Body
    
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
}

// MARK: Preview

struct TextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            RetinaTextField("Thats a default Textfield", onCommit: {print("party")})
            RetinaTextField("Thats a default Textfield + Icon", icon: Image(systemName: "star.fill"), onCommit: {print("party")})
            RetinaTextField("Primary", style: .primary, icon: Image(systemName: "star.fill"))
            RetinaTextField("Success", style: .success, icon: Image(systemName: "star.fill"))
            RetinaTextField("Warning", style: .warning, icon: Image(systemName: "star.fill"))
            RetinaTextField("Danger", style: .danger, icon: Image(systemName: "star.fill"))
            RetinaTextField("Info", style: .info, icon: Image(systemName: "star.fill"))
        }
        .padding()
    }
}
