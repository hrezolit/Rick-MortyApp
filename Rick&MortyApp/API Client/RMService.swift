//
//  RMService.swift
//  Rick&MortyApp
//
//  Created by Nikita on 13/1/23.
//

import Foundation

/// API service for geting Rick & Morty data
final class RMService {
    
    /// Singltone
    static let shared = RMService()
    
    private let cacheManager = RMAPICacheManager()
    
    /// Private contructor
    private init () {}
    
    enum RMErrorService: Error  {
        case faildWhileCreateRequset
        case faileWhileGetData
    }
    
    /// API Call
    /// - Parameters:
    ///   - request: Requesting instance
    ///   - type: The type of object we expecting to get back
    ///   - completion: Callback datat and error
    public func execute<T: Codable>(_ request: RMRequest,
                                    expecting type: T.Type,
                                    completion: @escaping (Result<T, Error>) -> Void) {
        
        if let cachedData = cacheManager.cacheResponse(for: request.endPoint, url: request.url) {
            
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            
            return
        }
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMErrorService.faildWhileCreateRequset))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data, error == nil else {
                completion(.failure(error ?? RMErrorService.faileWhileGetData))
                return
            }
            
            // Decode the response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                
                self?.cacheManager.setCache(for: request.endPoint, url: request.url, data: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    //MARK: - Private
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}
