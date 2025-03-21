//
//  AppThemeButton.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 21/03/25.
//


import SwiftUI

struct AppThemeButton: View {
    var title: String
    var buttonHeight: CGFloat = 50
    var buttonWidth: CGFloat? = nil
    var hasArrow: Bool = false
    var isDisabled: Bool = false
    var buttonType: ThemeButtonStyle
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: { if !isDisabled { action?() } }) {
            HStack {
                Text(title)
                    .foregroundColor(isDisabled ? .gray : .primary)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity)
                
                if hasArrow {
                    Text("→")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.trailing, 12)
                        .opacity(isDisabled ? 0.5 : 1.0)
                }
            }
            .frame(height: buttonHeight)
            .frame(width: buttonWidth)
        }
        .buttonStyle(buttonType)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1.0)
    }
}

// Preview
struct AppThemeButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            AppThemeButton(
                title: "Signup",
                hasArrow: true, buttonType: .coloured(fillColor: .blue)
            )
            AppThemeButton(
                title: "Login",
                hasArrow: true, buttonType: .bordered(borderColor: .gray)
            )
        }
        .padding()
    }
}
