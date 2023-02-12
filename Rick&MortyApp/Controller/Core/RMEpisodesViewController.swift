//
//  RMEpisodesViewController.swift
//  Rick&MortyApp
//
//  Created by Nikita on 12/1/23.
//

import UIKit

/// Controller for showing and searching episodes
class RMEpisodesViewController: UIViewController, RMEpisodeListViewDelegate {
    
    private let episodeListView = RMEpisodeListView()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Episodes"
        view.addSubview(episodeListView)
        
        addSearchButton()
        addConstraintsForList()
    }
    
    @objc func didTapSearch() {
        let vc = RMSearchViewController(config: .init(type: .episode))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private:
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 1, blue: 0.8206997514, alpha: 1)
    }
    
    /// setting up constraints for character list view
    private func addConstraintsForList() {
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        NSLayoutConstraint.activate([
            
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Delegate
    
    func rmEpisodeListView(_ rmEpisodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        
        //Show detail controller for that episode
        let detailVC = RMEpisodeDetailViewController(url: URL(string: episode.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
