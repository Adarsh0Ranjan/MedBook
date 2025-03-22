//
//  CountriesService.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 22/03/25.
//

import Foundation

protocol CountriesServiceProtocol {
    func getCountries(completion: @escaping CompletionHandler<CountryResponse>)
}

struct CountriesService: NetworkHelperProtocol, CountriesServiceProtocol {
    func getCountries(completion: @escaping CompletionHandler<CountryResponse>) {
        request(endpoint: CountriesServiceEndpoints.getCountries, responseType: CountryResponse.self, completion: completion)
    }
}

struct MockableCountriesService: CountriesServiceProtocol, NetworkHelperProtocol {
    func getCountries(completion: @escaping CompletionHandler<CountryResponse>) {
        print(#function)
    }
}

enum CountriesServiceEndpoints: Endpoint {
    
    case getCountries
    
    var path: String {
        return "https://api.first.org/data/v1/countries"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var body: [String: Any]? {
        return nil
    }
}
