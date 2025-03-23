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
        if let email = UserDefaultsHelper.getString(key: .userEmail) {
            bookmarkedBooks = CoreDataManager.shared.fetchBooks(forUser: email)
        } else {
            bookmarkedBooks = []
        }

    }
}
