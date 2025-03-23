//
//  ImageCacheManager.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//


import Foundation
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private let cache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    private let expiryInterval: TimeInterval = 7 * 24 * 60 * 60
    
    private init() {
        cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cleanExpiredCache()
    }
    
    /// Retrieve image from cache or disk
    func getImage(forKey key: String) -> UIImage? {
        let cacheKey = NSString(string: key)
        
        // Check in-memory cache first
        if let cachedImage = cache.object(forKey: cacheKey) {
            return cachedImage
        }
        
        // Check disk cache if not in memory
        let fileURL = fileURLForKey(key)
        guard let attributes = try? fileManager.attributesOfItem(atPath: fileURL.path),
              let modificationDate = attributes[.modificationDate] as? Date else {
            return nil
        }
        
        // Check if file is expired
        if Date().timeIntervalSince(modificationDate) > expiryInterval {
            try? fileManager.removeItem(at: fileURL)
            return nil
        }
        
        // Load image and update memory cache
        if let data = try? Data(contentsOf: fileURL), let image = UIImage(data: data) {
            cache.setObject(image, forKey: cacheKey)
            return image
        }
        
        return nil
    }
    
    /// Save image to cache (memory + disk)
    func saveImage(_ image: UIImage, forKey key: String) {
        let cacheKey = NSString(string: key)
        cache.setObject(image, forKey: cacheKey)
        
        let fileURL = fileURLForKey(key)
        if let data = image.jpegData(compressionQuality: 0.8) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }
    
    /// Removes expired cache files
    private func cleanExpiredCache() {
        DispatchQueue.global(qos: .background).async {
            guard let cacheFiles = try? self.fileManager.contentsOfDirectory(at: self.cacheDirectory, includingPropertiesForKeys: [.contentModificationDateKey], options: .skipsHiddenFiles) else { return }
            
            let expirationDate = Date().addingTimeInterval(-self.expiryInterval)
            
            for fileURL in cacheFiles {
                if let attributes = try? self.fileManager.attributesOfItem(atPath: fileURL.path),
                   let modificationDate = attributes[.modificationDate] as? Date,
                   modificationDate < expirationDate {
                    try? self.fileManager.removeItem(at: fileURL)
                }
            }
        }
    }
    
    /// Clears all cached images
    func clearCache() {
        cache.removeAllObjects()
        try? fileManager.removeItem(at: cacheDirectory)
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
    }
    
    /// Generates a valid file URL for caching
    private func fileURLForKey(_ key: String) -> URL {
        let safeKey = key.replacingOccurrences(of: "/", with: "_")
        return cacheDirectory.appendingPathComponent(safeKey)
    }
}
