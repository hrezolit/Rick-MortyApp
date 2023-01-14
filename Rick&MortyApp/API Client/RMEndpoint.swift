//
//  RMEndpoint.swift
//  Rick&MortyApp
//
//  Created by Nikita on 13/1/23.
//

import Foundation

/// API endpoints
@frozen enum RMEndpoint: String {
    /// endpoint for geting characters info
    case character
    
    /// endpoint for geting location info
    case location
    
    /// endpoint for geting episode info
    case episode
}
