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
    
    var targetURL: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://github.com/hrezolit")
        case .terms:
            return URL(string: "https://www.termsfeed.com/blog/sample-terms-and-conditions-template/")
        case .privacy:
            return URL(string: "https://app-privacy-policy-generator.firebaseapp.com")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com")
        case .viewSeries:
            return URL(string: "https://www.ts.kg/show/rick_and_morty")
        case .viewCode:
            return URL(string: "https://github.com/hrezolit/Rick-MortyApp")
        }
    }
    
    // Color for icon container
    var iconContainerColor: UIColor {
        
        switch self {
        case .rateApp:
            return #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        case .contactUs:
            return #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        case .terms:
            return #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        case .privacy:
            return #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        case .apiReference:
            return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case .viewSeries:
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
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
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API Reference"
        case .viewSeries:
            return "View Video Series"
        case .viewCode:
            return "View App's Code"
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
