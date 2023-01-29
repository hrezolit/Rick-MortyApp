//
//  RMGetAllEpisodesResponse.swift
//  Rick&MortyApp
//
//  Created by Nikita on 29/1/23.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMEpisode]
}
