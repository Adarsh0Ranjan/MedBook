//
//  BookSearchResponse.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import Foundation

struct BookSearchResponse: Codable {
    let numFound: Int
    let start: Int
    let numFoundExact: Bool?
    let docs: [Book]
}

struct Book: Codable, Identifiable, Hashable {
    var id: String { key }
    let key: String
    let title: String
    let author_name: [String]?
    let cover_i: Int?
    let first_publish_year: Int?
    let edition_count: Int?
    let ratings_average: Double?
    let ratings_count: Int?
    let subject: [String]?
    let isbn: [String]?
    let lccn: [String]?
    
    // Implement Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.key == rhs.key
    }
}


extension Book {
    var coverImageURL: String? {
        if let coverID = cover_i {
            return "https://covers.openlibrary.org/b/id/\(coverID)-M.jpg"
        }
        return nil
    }
}
