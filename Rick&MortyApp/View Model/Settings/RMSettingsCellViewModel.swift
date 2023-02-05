//
//  RMSettingsCellViewModel.swift
//  Rick&MortyApp
//
//  Created by Nikita on 5/2/23.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable, Hashable {
    
    let id = UUID()
    
    private let type: RMSettingsOption
    
    // MARK: - init
    
    init(type: RMSettingsOption) {
        self.type = type
    }
    
    // MARK: - Public
    
    public var image: UIImage? {
        return type.displayIcon
    }
    
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
    
    
    
}
