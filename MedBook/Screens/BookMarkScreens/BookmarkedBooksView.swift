//
//  BookmarkedBooksView.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import SwiftUI

struct BookmarkedBooksView: View {
    @StateObject var viewModel = BookmarkedBooksViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.bookmarkedBooks, id: \.key) { book in
                BookRowView(book: book, onBookmarkRemoved: {
                    viewModel.loadBookmarkedBooks()
                })
            }
            .navigationTitle("Bookmarked Books")
        }
    }
}

