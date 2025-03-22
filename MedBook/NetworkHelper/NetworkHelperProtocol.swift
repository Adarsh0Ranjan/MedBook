//
//  NetworkHelperProtocol.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 22/03/25.
//


import Foundation

typealias CompletionHandler<T> = (Result<T, Error>) -> Void


protocol NetworkHelperProtocol {
    func request<T: Decodable>(endpoint: Endpoint, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

extension NetworkHelperProtocol {
    func request<T: Decodable>(endpoint: Endpoint, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        var components = URLComponents(string: endpoint.path)
        
        guard let url = components?.url else {
            print("Invalid URL: \(endpoint.path)")
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        print("Request: \(request.httpMethod ?? "GET") \(url.absoluteString)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid Response", code: 0, userInfo: nil)))
                return
            }
            
            print("Response Code: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Server Error: \(httpResponse.statusCode)")
                completion(.failure(NSError(domain: "Server Error", code: httpResponse.statusCode, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                print("No Data Received")
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch {
                print("JSON Decoding Failed: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
