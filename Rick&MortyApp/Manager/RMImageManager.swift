//
//  RMImageManager.swift
//  Rick&MortyApp
//
//  Created by Nikita on 21/1/23.
//

import Foundation

final class RMImageManager {
    static let shared = RMImageManager()
    
    private init() {}
    
    private var imageDataCache = NSCache <NSString, NSData>()
    
    // MARK: - Public:
    
    /// Get image with URL
    /// - Parameters:
    ///   - url: Source URL
    ///   - completion: Callback
    public func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void ) {
        let key = url.absoluteString as NSString
        
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data))
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            
            completion(.success(data))
        }
        task.resume()
    }
}
