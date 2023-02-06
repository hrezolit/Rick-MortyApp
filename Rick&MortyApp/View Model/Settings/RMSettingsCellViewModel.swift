//
//  RMSettingsCellViewModel.swift
//  Rick&MortyApp
//
//  Created by Nikita on 5/2/23.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable {
    
    let id = UUID()
    
    public let type: RMSettingsOption
    public let onTapHandler: (RMSettingsOption) -> Void
    
    // MARK: - init
    
    init(type: RMSettingsOption, onTapHandler: @escaping (RMSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
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
