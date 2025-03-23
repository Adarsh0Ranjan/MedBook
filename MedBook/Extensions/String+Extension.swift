//
//  String+Extension.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import UIKit


extension String {
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        print("Checking cache for image: \(self)")
        
        if let cachedImage = ImageCacheManager.shared.getImage(forKey: self) {
            print("Image found in cache: \(self)")
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: self) else {
            print("Invalid URL: \(self)")
            completion(nil)
            return
        }
        
        print("Downloading image from URL: \(self)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                print("Image downloaded successfully: \(self)")
                
                ImageCacheManager.shared.saveImage(image, forKey: self)
                print("Image cached successfully: \(self)")
                
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                print("Failed to decode image data: \(self)")
                completion(nil)
            }
        }.resume()
    }
}
