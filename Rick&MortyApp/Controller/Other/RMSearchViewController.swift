//
//  RMSearchViewController.swift
//  Rick&MortyApp
//
//  Created by Nikita on 29/1/23.
//

import UIKit

/// Search controller's configurations
final class RMSearchViewController: UIViewController {
    
    /// Configuration for search session
    struct Config {
        enum `Type` {
            case character
            case episode
            case location
            
            var title: String {
                switch self {
                case .episode:
                    return "Search episodes"
                case .location:
                    return "Search locations"
                case .character:
                    return "Search characters"
                }
            }
        }
        
        let type: `Type`
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = config.type.title
        view.backgroundColor = .systemBackground
    }
}
