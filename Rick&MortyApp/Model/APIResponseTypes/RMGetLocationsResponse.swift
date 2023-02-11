//
//  RMGetLocationsResponse.swift
//  Rick&MortyApp
//
//  Created by Nikita on 8/2/23.
//

import Foundation

/// Model for all locations response
struct RMGetAllLocationsResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMLocation]
}
