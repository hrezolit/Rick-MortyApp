//
//  RMSettingsOption.swift
//  Rick&MortyApp
//
//  Created by Nikita on 5/2/23.
//

import UIKit

/// Setting's options
enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    // Color for icon container
    var iconContainerColor: UIColor {
        
        switch self {
        case .rateApp:
            return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case .contactUs:
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case .terms:
            return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case .privacy:
            return #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        case .apiReference:
            return #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        case .viewSeries:
            return #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        case .viewCode:
            return #colorLiteral(red: 1, green: 0.2340943213, blue: 0.2250429188, alpha: 1)
        }
    }
    
    /// Setting's titles
    var displayTitle: String {
        
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API reference"
        case .viewSeries:
            return "View video series"
        case .viewCode:
            return "View app code"
        }
    }
    
    /// Setting's icons
    var displayIcon: UIImage? {
        
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.circle.fill")
        case .contactUs:
            return UIImage(systemName: "envelope.fill")
        case .terms:
            return UIImage(systemName: "scroll.fill")
        case .privacy:
            return UIImage(systemName: "lock.shield.fill")
        case .apiReference:
            return UIImage(systemName: "link")
        case .viewSeries:
            return UIImage(systemName: "video.fill")
        case .viewCode:
            return UIImage(systemName: "chevron.left.forwardslash.chevron.right")
        }
    }
}
