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
    
    /// Private contructor
    private init () {}
    
    /// API Call
    /// - Parameters:
    ///   - request: Requesting instance
    ///   - type: The type of object we expecting to get back
    ///   - complition: Callback datat and error
    public func execute<T: Codable>(_ request: RMRequest,
                                    expecting type: T.Type,
                                    complition: @escaping (Result<String, Error>) -> Void) {
        
    }
    
    
}
