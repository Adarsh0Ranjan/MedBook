//
//  SearchBarView.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var onSearch: () -> Void
    
    var body: some View {
        VStack {
            Text("Which topic interests you today?")
                .font(.title2)
                .fontWeight(.medium)
                .padding(.horizontal)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search for books", text: $searchText)
                    .onChange(of: searchText) { _ in
                        onSearch()
                    }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}
