//
//  RMTabViewController.swift
//  Rick&MortyApp
//
//  Created by Nikita on 12/1/23.
//

import UIKit

/// Controller for tab bar
final class RMTabViewController: UITabBarController {

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTabs()
    }
    
    /// seting up icons and titles for tab bar
    private func setUpTabs() {
        
        let charactersVC = RMCharactersViewController()
        let locationsVC = RMLocationViewController()
        let episodesVC = RMEpisodesViewController()
        let settingsVC = RMSettingsViewController()
        
        charactersVC.navigationItem.largeTitleDisplayMode = .always
        locationsVC.navigationItem.largeTitleDisplayMode = .always
        episodesVC.navigationItem.largeTitleDisplayMode = .always
        settingsVC.navigationItem.largeTitleDisplayMode = .always
        
        let navigationController1 = UINavigationController(rootViewController: charactersVC)
        let navigationController2 = UINavigationController(rootViewController: locationsVC)
        let navigationController3 = UINavigationController(rootViewController: episodesVC)
        let navigationController4 = UINavigationController(rootViewController: settingsVC)
        
        navigationController1.tabBarItem = UITabBarItem(title: "Characters",
                                                        image: UIImage(systemName: "figure.fall"),
                                                        tag: 1)
        navigationController2.tabBarItem = UITabBarItem(title: "Locations",
                                                        image: UIImage(systemName: "location.north"),
                                                        tag: 2)
        navigationController3.tabBarItem = UITabBarItem(title: "Episodes",
                                                        image: UIImage(systemName: "books.vertical"),
                                                        tag: 3)
        navigationController4.tabBarItem = UITabBarItem(title: "Settings",
                                                        image: UIImage(systemName: "slider.horizontal.3"),
                                                        tag: 4)
        
        for navigationController in [navigationController1,
                                     navigationController2,
                                     navigationController3,
                                     navigationController4] {
            
            navigationController.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [navigationController1,
             navigationController2,
             navigationController3,
             navigationController4],
            
            animated: true
        )
    }
}

