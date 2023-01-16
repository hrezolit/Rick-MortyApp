//
//  RMCharactersViewController.swift
//  Rick&MortyApp
//
//  Created by Nikita on 12/1/23.
//

import UIKit

/// Controller for showing and searching characters
final class RMCharactersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Characters"
        
        RMService.shared.execute(.listCharacterRequest, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total: " + "\(model.info.count)")
                print("Page result count: " + "\(model.results.count)")
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
