//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  Rick&MortyApp
//
//  Created by Nikita on 24/1/23.
//

import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    
    private let value: String
    private let type: `Type`
    
    public var title: String {
        type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty { return "None"}
        return value
    }
    
    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var tintColor: UIColor {
        return type.tintColor
    }
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return #colorLiteral(red: 0.2617170892, green: 1, blue: 0.9686274529, alpha: 1)
            case .gender:
                return #colorLiteral(red: 0.2617170892, green: 0.8846282959, blue: 0.9686274529, alpha: 1)
            case .type:
                return #colorLiteral(red: 0.2617170892, green: 0.8042575551, blue: 0.9686274529, alpha: 1)
            case .species:
                return #colorLiteral(red: 0.2617170892, green: 0.7122088582, blue: 0.9686274529, alpha: 1)
            case .origin:
                return #colorLiteral(red: 0.2617170892, green: 0.6526645998, blue: 0.9686274529, alpha: 1)
            case .location:
                return #colorLiteral(red: 0.2617170892, green: 0.610600997, blue: 0.9686274529, alpha: 1)
            case .created:
                return #colorLiteral(red: 0.2617170892, green: 0.5267766836, blue: 0.9686274529, alpha: 1)
            case .episodeCount:
                return #colorLiteral(red: 0.2617170892, green: 0.4482013936, blue: 0.9686274529, alpha: 1)
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "person.fill.questionmark")
            case .gender:
                return UIImage(systemName: "figure.dress.line.vertical.figure")
            case .type:
                return UIImage(systemName: "poweroutlet.type.e")
            case .species:
                return UIImage(systemName: "figure.wrestling")
            case .origin:
                return UIImage(systemName: "bubbles.and.sparkles")
            case .location:
                return UIImage(systemName: "mappin.and.ellipse")
            case .created:
                return UIImage(systemName: "birthday.cake")
            case .episodeCount:
                return UIImage(systemName: "film.stack")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status, .type, .gender, .species, .origin, .location, .created:
                return rawValue.uppercased()
            case .episodeCount:
                return "EPISODE COUNT"
            }
        }
    }
    
    init(
        type: `Type`,
        value: String
    ) {
        self.type = type
        self.value = value
    }
}
