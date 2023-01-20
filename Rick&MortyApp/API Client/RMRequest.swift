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
    private let pathComponetnts: [String]
    
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
        pathComponetnts: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endPoint = endPoint
        self.pathComponetnts = pathComponetnts
        self.queryParameters = queryParameters
    }
    
    convenience init? (url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseURL) {
            return nil
        }
        
        let trimmed = string.replacingOccurrences(of: Constants.baseURL + "/",
                                                  with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endPoint: rmEndpoint)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap {
                    guard $0.contains("=") else { return nil }
                    let parts = $0.components(separatedBy: "=")
          
                    return URLQueryItem(name: parts[0],
                                        value: parts[1])
                }
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endPoint: rmEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
}

extension RMRequest {
    
    static let listCharacterRequest = RMRequest(endPoint: .character)
}
