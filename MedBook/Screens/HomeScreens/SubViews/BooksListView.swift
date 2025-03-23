//
//  BooksListView.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import SwiftUI

struct BooksListView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.filteredBooks) { book in
                BookRowView(book: book)
                    .onAppear {
                        if book == viewModel.filteredBooks.last {
                            viewModel.loadMoreBooks()
                        }
                    }
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .listStyle(PlainListStyle())
    }
}
