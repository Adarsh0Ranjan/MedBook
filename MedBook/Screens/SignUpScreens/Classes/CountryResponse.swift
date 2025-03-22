//
//  CountryResponse.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 22/03/25.
//


struct CountryResponse: Decodable {
    let data: [String: Country]
}

struct Country: Decodable {
    let country: String
    let region: String
}
