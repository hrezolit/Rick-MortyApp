//
//  RMCharacterStatus.swift
//  Rick&MortyApp
//
//  Created by Nikita on 13/1/23.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var text: String {
        switch self {
        case .alive:
            return rawValue
        case .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
