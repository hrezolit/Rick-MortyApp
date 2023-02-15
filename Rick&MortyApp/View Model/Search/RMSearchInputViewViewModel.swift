//
//  RMSearchInputViewViewModel.swift
//  Rick&MortyApp
//
//  Created by Nikita on 8/2/23.
//

import Foundation

final class RMSearchInputViewViewModel {
    
    private let type: RMSearchViewController.Config.`Type`
    
    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
        
        var choices: [String] {
            switch self {
                
            case .status:
                return ["alive", "dead", "unknown"]
                
            case .gender:
                return ["male", "female", "genderless", "unknown" ]
                
            case .locationType:
                return ["planet", "microverse", "station", "tv", "cluster"]
            }
        }
    }
    
    init(type: RMSearchViewController.Config.`Type`) {
        
        self.type = type
    }
    
    public var hasDynamicOption: Bool {
        switch self.type {
        case .character, .location:
            return true
        case .episode:
            return false
        }
    }
    
    public var options: [DynamicOption] {
        switch self.type {
            
        case .character:
            return [.status, .gender]
        case .location:
            return [.locationType]
        case .episode:
            return []
        }
    }
    
    public var searchPlaceholderText: String{
        switch self.type {
            
        case .character:
            return "Search character"
        case .location:
            return "Search location"
        case .episode:
            return "Search episode"
        }
    }
}

