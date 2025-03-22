//
//  Endpoint.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 22/03/25.
//


protocol Endpoint {
    var path: String { get }
    var method: RequestMethod { get }
    var body: [String: Any]? { get }
}
