//
//  HomeView.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//


import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel(bookService: BookService())
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HeaderView(viewModel: viewModel)
                
                // Search Section
                SearchBarView(searchText: $viewModel.searchText, onSearch: viewModel.debouncedSearch)
                
                // Sorting Options
                
                if !viewModel.books.isEmpty {
                    SortOptionsView(selectedSortOption: $viewModel.selectedSortOption) {
                        viewModel.sortBooks()
                    }
                }
                
                // Books List
                BooksListView(viewModel: viewModel)
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
