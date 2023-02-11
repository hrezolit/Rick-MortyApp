//
//  RMLocationViewController.swift
//  Rick&MortyApp
//
//  Created by Nikita on 12/1/23.
//

import UIKit

/// Controller for showing and searching locations
final class RMLocationViewController: UIViewController {

    private let primaryView = RMLocationView()
    
    private let viewModel = RMLocationViewViewModel()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        primaryView.delegate = self
        view.addSubview(primaryView)
        
        title = "Locations"
        
        addSearchButton()
        addConstraints()
        viewModel.delegate = self
        viewModel.fetchLoactions()
    }
    
    @objc func didTapSearch() {
        let vc = RMSearchViewController(config: .init(type: .location))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private:
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
        
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - extensions:

extension RMLocationViewController: RMLocationViewViewModelDelegate {
    
    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
}

extension RMLocationViewController: RMLocationViewDelegate {
    
    func rmLocationView(_ locationView: RMLocationView, didSelec location: RMLocation) {
        let vc = RMLocationDetailViewController(location: location)
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
