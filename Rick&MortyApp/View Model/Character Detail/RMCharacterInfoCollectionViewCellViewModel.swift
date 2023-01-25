//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  Rick&MortyApp
//
//  Created by Nikita on 24/1/23.
//

import Foundation

final class RMCharacterInfoCollectionViewCellViewModel {
    
    public let title: String
    public let value: String
    
    init(
        title: String,
        value: String
    ) {
        self.title = title
        self.value = value
    }
}
