//
//  RMEpisodeDetailViewController.swift
//  Rick&MortyApp
//
//  Created by Nikita on 27/1/23.
//

import UIKit

class RMEpisodeDetailViewController: UIViewController {
    
    private let url: URL?
    
    //MARK: - init
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Episode"
        view.backgroundColor = .systemBackground
        
    }
}
