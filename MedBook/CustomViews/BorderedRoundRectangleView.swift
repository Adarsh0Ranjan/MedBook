//
//  BorderedRoundRectangleView.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 21/03/25.
//


import SwiftUI

struct BorderedRoundRectangleView: View {
    var cornerRadius: CGFloat
    var borderColor: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(borderColor, lineWidth: 2)
    }
}