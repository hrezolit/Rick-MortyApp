//
//  RMLocationTableViewCellViewModel.swift
//  Rick&MortyApp
//
//  Created by Nikita on 8/2/23.
//

import Foundation

struct RMLocationTableViewCellViewModel: Hashable, Equatable {
    
    private let location: RMLocation
    
    init(locataion: RMLocation) {
        self.location = locataion
    }
    
    public var name: String {
        return "Location: "+location.name
    }
    
    public var type: String {
        return "Type: "+location.type
    }
    
    public var dimension: String {
        return "Dimension: "+location.dimension
    }
    
    static func == (lhs: RMLocationTableViewCellViewModel, rhs: RMLocationTableViewCellViewModel) -> Bool {
        return lhs.location.id == rhs.location.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(location.id)
        hasher.combine(dimension)
        hasher.combine(type)
    }
}
