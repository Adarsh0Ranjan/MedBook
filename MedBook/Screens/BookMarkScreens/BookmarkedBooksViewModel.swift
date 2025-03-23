//
//  BookmarkedBooksViewModel.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import Foundation

class BookmarkedBooksViewModel: ObservableObject {
    @Published var bookmarkedBooks: [Book] = []
    
    init() {
        loadBookmarkedBooks()
    }
    
    func loadBookmarkedBooks() {
        bookmarkedBooks = CoreDataManager.shared.fetchBooks(forUser: "02130adarsh@gmail.com")
    }
}
