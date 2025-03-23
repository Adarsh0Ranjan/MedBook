//
//  HeaderView.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import SwiftUI

struct HeaderView: View {
    var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "book.fill")
                .font(.title)
            
            Text("MedBook")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            // Bookmark Button
            Button(action: {
                // viewModel.showBookmarks.toggle()
            }) {
                Image(systemName: "bookmark.fill")
                    .foregroundStyle(Color.green)
            }
            
            // Logout Button
            Button(action: {
                viewModel.handleLogOut()
            }) {
                Image(systemName: "x.circle")
                    .foregroundStyle(Color.red)
            }
        }
        .padding(.horizontal)
    }
}
