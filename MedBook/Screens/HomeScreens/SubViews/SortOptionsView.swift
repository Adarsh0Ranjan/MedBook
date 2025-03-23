//
//  SortOptionsView.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import SwiftUI

struct SortOptionsView: View {
    @Binding var selectedSortOption: SortOption
    var onSortChange: () -> Void
    
    var body: some View {
        HStack {
            Text("Sort By:")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            ForEach(SortOption.allCases, id: \.self) { option in
                Button(action: {
                    selectedSortOption = option
                    onSortChange()
                }) {
                    Text(option.rawValue)
                        .padding(6)
                        .background(selectedSortOption == option ? Color.gray.opacity(0.3) : Color.clear)
                        .cornerRadius(6)
                }
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
}
