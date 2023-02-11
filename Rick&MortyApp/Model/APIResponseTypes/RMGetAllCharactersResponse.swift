//
//  RMGetAllCharactersResponse.swift
//  Rick&MortyApp
//
//  Created by Nikita on 16/1/23.
//

import Foundation

/// Model for all characters response
struct RMGetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMCharacter]
}


