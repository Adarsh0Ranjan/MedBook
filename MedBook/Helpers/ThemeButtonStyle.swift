//
//  ThemeButtonStyle.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 21/03/25.
//


import Foundation
import SwiftUI

enum ThemeButtonStyle: ButtonStyle {
    
    case bordered(borderColor: Color)
    case coloured(fillColor: Color, disabled: Bool = false)
    
    func makeBody(configuration: Configuration) -> some View {
        switch self {
        case .bordered(let color):
            configuration.label
                .frame(height: 50)
                .background(
                    BorderedRoundRectangleView(cornerRadius: 8, borderColor: color)
                )
                .opacity(configuration.isPressed ? 0.7 : 1)
            
        case .coloured(let color, let disabled):
            configuration.label
                .frame(height: 50)
                .background(
                    ZStack {
                        if disabled {
                            Color.gray.opacity(0.5)
                                .cornerRadius(8)
                        } else {
                            color
                                .cornerRadius(8)
                        }
                    }
                )
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
}
