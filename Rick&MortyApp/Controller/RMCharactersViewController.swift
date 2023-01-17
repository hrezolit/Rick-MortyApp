//
//  RMCharactersViewController.swift
//  Rick&MortyApp
//
//  Created by Nikita on 12/1/23.
//

import UIKit

/// Controller for showing and searching characters
final class RMCharactersViewController: UIViewController {

    private let charatcterListView = CharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Characters"
        view.addSubview(charatcterListView)
        
        NSLayoutConstraint.activate([
        
            charatcterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            charatcterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            charatcterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            charatcterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
