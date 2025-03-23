//
//  HomeViewModel.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//


import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText: String = "" {
        didSet { debouncedSearch() }
    }
    @Published var bookmarkedBooks: Set<Book> = []
    @Published var bookCovers: [String: Data] = [:]  // Caching book covers
    
    @Published var selectedSortOption: SortOption = .title // Missing Property
    private let bookService: BookServiceProtocol
    private var currentOffset = 0
    private let limit = 10
    private var isLastPage = false
    private var searchTimer: Timer?
    private var cancellables = Set<AnyCancellable>()
    
    init(bookService: BookServiceProtocol) {
        self.bookService = bookService
    }
    
    /// Computed property for filtering and sorting books
    var filteredBooks: [Book] {
        var sortedBooks = books
        
        switch selectedSortOption {
        case .title:
            sortedBooks.sort { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        case .average:
            sortedBooks.sort { ($0.ratings_average ?? 0) > ($1.ratings_average ?? 0) }
        case .hits:
            sortedBooks.sort { ($0.ratings_count ?? 0) > ($1.ratings_count ?? 0) }
        }
        
        return sortedBooks
    }

    /// Fetch books with pagination support
    func fetchBooks(query: String, isPaginating: Bool = false) {
        guard !isLoading, !isLastPage else { return }
        
        isLoading = true
        errorMessage = nil
        
        bookService.searchBooks(query: query, limit: limit, offset: currentOffset) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let response):
                    let newBooks = response.docs
                    print("Fetched Books: \(newBooks)") // Print the fetched books
                    
                    if newBooks.isEmpty {
                        self.isLastPage = true
                        print("No more books available.")
                    } else {
                        self.books.append(contentsOf: newBooks)
                        self.currentOffset += self.limit
                        print("Total books loaded: \(self.books.count)")
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error fetching books: \(error.localizedDescription)")
                }
            }
        }
    }

    
    /// Resets books and starts a new search
    func resetBooks(query: String) {
        books.removeAll()
        currentOffset = 0
        isLastPage = false
        fetchBooks(query: query)
    }
    
    /// Debounced search to optimize API calls
    func debouncedSearch() {
        searchTimer?.invalidate()
        
        let trimmedQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmedQuery.count >= 3 else {
            print("No search required - Not enough characters")
            books.removeAll()
            return
        }
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            print("Searching for books with title: \(trimmedQuery)")
            self?.resetBooks(query: trimmedQuery)
        }
    }
    
    /// Handles sorting of books
    func sortBooks() {
        objectWillChange.send()
    }
    
    /// Handles user logout
    func handleLogOut() {
        UserDefaultsHelper.removeValue(key: .userEmail)
        AppRootView.updateRootViewTo(.landingScreen)
    }
    
    /// Remove book from bookmarks
    func removeFromBookmarks(book: Book) {
        bookmarkedBooks.remove(book)
    }
    
    /// Fetch next page of books
    func loadMoreBooks() {
        fetchBooks(query: searchText, isPaginating: true)
    }
}
