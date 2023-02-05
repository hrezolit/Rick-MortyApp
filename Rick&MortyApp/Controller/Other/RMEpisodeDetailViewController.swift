//
//  RMEpisodeDetailViewController.swift
//  Rick&MortyApp
//
//  Created by Nikita on 27/1/23.
//

import UIKit

/// Presenting details of single episode
final class RMEpisodeDetailViewController: UIViewController, RMEpisodeDetailViewViewModelDelegate, RMEpisodeDetailViewDelegate {
  
    private let viewModel: RMEpisodeDetailViewViewModel
    private let detailView = RMEpisodeDetailView()
    
    //MARK: - init
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailViewViewModel(endpointURL: url)
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
        view.addSubview(detailView)
        detailView.delegate = self
        addConstraints()
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func didTapShare() {
        
    }
    // MARK: - View delegate:
    
    func rmEpisodeDetailView(_ detailView: RMEpisodeDetailView, didSelect character: RMCharacter) {
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - ViewModel Delegate:
    
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
}


