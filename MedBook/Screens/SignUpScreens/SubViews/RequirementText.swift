//
//  RequirementText.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 21/03/25.
//

import SwiftUI

struct RequirementText: View {
    let text: String
    let isMet: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isMet ? "checkmark.square.fill" : "square")
                .foregroundColor(isMet ? .green : .gray)
            Text(text).font(.caption)
        }
    }
}
