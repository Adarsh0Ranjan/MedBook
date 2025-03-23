//
//  BookRowView.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import SwiftUI

struct BookRowView: View {
    let book: Book
    @State private var bookImage: UIImage? = nil
    @State private var isBookmarked: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            // Book Cover
            if let image = bookImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 50, height: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .shadow(radius: 2)
            } else {
                Color.gray.opacity(0.3)
                    .frame(width: 50, height: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .shadow(radius: 2)
                    .onAppear {
                        if let imageUrl = book.coverImageURL {
                            imageUrl.loadImage { image in
                                self.bookImage = image
                            }
                        }
                    }
            }
            
            // Book Details
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.system(size: 16, weight: .bold))
                    .lineLimit(1)
                
                if let author = book.author_name?.first {
                    Text(author)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                
                HStack(spacing: 6) {
                    if let rating = book.ratings_average {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.yellow)
                        Text("\(rating, specifier: "%.1f")")
                            .font(.system(size: 14))
                    }
                    
                    if let ratingsCount = book.ratings_count {
                        Image(systemName: "doc.text")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.gray)
                        Text("\(ratingsCount)")
                            .font(.system(size: 14))
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(action: {
                isBookmarked.toggle()
                handleBookmarkAction()
            }) {
                Label(isBookmarked ? "Remove" : "Bookmark", systemImage: isBookmarked ? "bookmark.fill" : "bookmark")
            }
            .tint(isBookmarked ? .red : .green)
        }
        .onAppear {
            checkIfBookmarked()
        }
    }
    
    // Function to handle adding/removing a bookmark
    private func handleBookmarkAction() {
        if isBookmarked {
            print("Added to bookmarks: \(book.title)")
        } else {
            print("Removed from bookmarks: \(book.title)")
        }
    }
    
    // Function to check if the book is already bookmarked
    private func checkIfBookmarked() {
        // You can check from UserDefaults or CoreData if the book is bookmarked
    }
}
