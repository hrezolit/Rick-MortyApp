//
//  RMLocationDetailViewController.swift
//  Rick&MortyApp
//
//  Created by Nikita on 8/2/23.
//

import UIKit

/// Presenting details of single episode
final class RMLocationDetailViewController: UIViewController, RMLocationDetailViewViewModelDelegate, RMLocationDetailViewDelegate {
  
    private let viewModel: RMLocationDetailViewViewModel
    private let detailView = RMLocationDetailView()
    
    //MARK: - init
    init(location: RMLocation) {
        let url = URL(string: location.url)
        self.viewModel = RMLocationDetailViewViewModel(endpointURL: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Location"
        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        detailView.delegate = self
        addConstraints()
        viewModel.delegate = self
        viewModel.fetchLocationData()
    }
    
    @objc func didTapShare() {
        
    }
    
    // MARK: - Private:
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - View delegate:
    
    func rmLocationDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter) {
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - ViewModel Delegate:
    
    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
}



