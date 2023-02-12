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
 
    private let viewModel: RMSearchViewViewModel
    private let searchView: RMSearchView
    
    // MARK: - init
    
    init(config: Config) {
        let viewModel = RMSearchViewViewModel(config: config)
        self.viewModel = viewModel
        self.searchView = RMSearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
        
        addConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(didTapExecuteSearch))
        
        searchView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchView.presentKeyboard()
    }
    
    
    // MARK: - Private:
    
    @objc private func didTapExecuteSearch() {
//        viewModel.executeSearch()
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
        
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


// MARK: - extension

// RMSearchView Delegate
extension RMSearchViewController: RMSearchViewDelegate {
    
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        print("Should present option picker")
    }
}
