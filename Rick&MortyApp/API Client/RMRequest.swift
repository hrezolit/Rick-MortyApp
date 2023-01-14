//
//  RMRequest.swift
//  Rick&MortyApp
//
//  Created by Nikita on 13/1/23.
//

import Foundation

/// Single API call
final class RMRequest {
    
    /// API Constants
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    /// Endpoint
    private let endPoint: RMEndpoint
    
    /// Path componets for API
    private let pathComponetnts: Set<String>
    
    /// Query parametrs for API
    private let queryParameters: [URLQueryItem]
    
    ///  Preparing url for API request
    private var urlString: String {
        var string = Constants.baseURL
        string += "/"
        string += endPoint.rawValue
        
        if !pathComponetnts.isEmpty {
            pathComponetnts.forEach {
                string += "/\($0)"
            }
        }
        
        if !queryParameters.isEmpty {
            
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    
    /// Making API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// HTTP Method
    public let httpMethod = "GET"
    
    
    //MARK: - Public
    /// Construct request
    /// - Parameters:
    ///   - endPoint: Target endpoint
    ///   - pathComponetnts: Collection of path componetns
    ///   - queryParameters: Collection of query parameters
    public init(
        endPoint: RMEndpoint,
        pathComponetnts: Set<String> = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endPoint = endPoint
        self.pathComponetnts = pathComponetnts
        self.queryParameters = queryParameters
    }
}
