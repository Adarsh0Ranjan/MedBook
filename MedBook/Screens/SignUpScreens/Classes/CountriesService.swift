//
//  CountriesService.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 22/03/25.
//

import Foundation

protocol CountriesServiceProtocol {
    func getCountries(completion: @escaping CompletionHandler<CountryResponse>)
    func getUserLocation(completion: @escaping CompletionHandler<UserLocation>)
}

struct CountriesService: NetworkHelperProtocol, CountriesServiceProtocol {
    func getCountries(completion: @escaping CompletionHandler<CountryResponse>) {
        request(endpoint: CountriesServiceEndpoints.getCountries, responseType: CountryResponse.self, completion: completion)
    }
    
    func getUserLocation(completion: @escaping CompletionHandler<UserLocation>) {
        request(endpoint: CountriesServiceEndpoints.getUserLocation, responseType: UserLocation.self, completion: completion)
    }
}

struct MockableCountriesService: CountriesServiceProtocol, NetworkHelperProtocol {
    func getCountries(completion: @escaping CompletionHandler<CountryResponse>) {
        print(#function)
    }
    
    func getUserLocation(completion: @escaping CompletionHandler<UserLocation>) {
        print(#function)
    }
}

enum CountriesServiceEndpoints: Endpoint {
    case getCountries
    case getUserLocation
    
    var path: String {
        switch self {
        case .getCountries:
            return "https://api.first.org/data/v1/countries"
        case .getUserLocation:
            return "http://ip-api.com/json"
        }
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var body: [String: Any]? {
        return nil
    }
}

// Model for User Location API response

