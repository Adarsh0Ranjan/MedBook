//
//  NetworkHelperProtocol.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 22/03/25.
//


import Foundation

protocol NetworkHelperProtocol {
    func request<T: Decodable>(url: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

extension NetworkHelperProtocol {
    func request<T: Decodable>(url: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Server Error", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
