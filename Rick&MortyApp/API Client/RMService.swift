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
    ///   - complition: Callback datat and error
    public func execute(_ request: RMRequest, complition: @escaping () -> Void) {
        
    }
    
    
}
