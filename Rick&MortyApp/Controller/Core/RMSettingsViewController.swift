//
//  RMSettingsViewController.swift
//  Rick&MortyApp
//
//  Created by Nikita on 12/1/23.
//

import UIKit

/// Controller for showing application's settings
final class RMSettingsViewController: UIViewController {

    private let viewModel = RMSettingsOption.allCases.compactMap {
        
        return RMSettingsCellViewModel(type: $0)
    }
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
    }
}
