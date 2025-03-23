//
//  BookService.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import Foundation

protocol BookServiceProtocol {
    func searchBooks(query: String, limit: Int, offset: Int, completion: @escaping CompletionHandler<BookSearchResponse>)
}

struct BookService: NetworkHelperProtocol, BookServiceProtocol {
    func searchBooks(query: String, limit: Int = 10, offset: Int = 0, completion: @escaping CompletionHandler<BookSearchResponse>) {
        let endpoint = BookServiceEndpoints.searchBooks(query: query, limit: limit, offset: offset)
        request(endpoint: endpoint, responseType: BookSearchResponse.self, completion: completion)
    }
}

struct MockableBookService: BookServiceProtocol, NetworkHelperProtocol {
    func searchBooks(query: String, limit: Int, offset: Int, completion: @escaping CompletionHandler<BookSearchResponse>) {
        print(#function, "Query: \(query)")
    }
}

enum BookServiceEndpoints: Endpoint {
    case searchBooks(query: String, limit: Int, offset: Int)
    
    var path: String {
        switch self {
        case .searchBooks(let query, let limit, let offset):
            return "https://openlibrary.org/search.json?title=\(query)&limit=\(limit)&offset=\(offset)"
        }
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var body: [String: Any]? {
        return nil
    }
}
