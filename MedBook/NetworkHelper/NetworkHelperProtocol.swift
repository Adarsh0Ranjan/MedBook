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

extension NetworkHelperProtocol {
    
    func uploadImage(endpoint: Endpoint, image: UIImage, imageParamName: String = "file", completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "Image Conversion Error", code: 0)))
            return
        }
        
        var components = URLComponents(string: endpoint.path)
        guard let url = components?.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Build multipart body
        var body = Data()
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(imageParamName)\"; filename=\"image.jpg\"\r\n")
        body.append("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n")
        
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0)))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
            
        }.resume()
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

