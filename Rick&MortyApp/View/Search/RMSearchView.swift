//
//  RMSearchView.swift
//  Rick&MortyApp
//
//  Created by Nikita on 8/2/23.
//

import UIKit

protocol RMSearchViewDelegate: AnyObject {
    
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}

/// Search view
final class RMSearchView: UIView {

    weak var delegate: RMSearchViewDelegate?
    
    private let viewModel: RMSearchViewViewModel
    
    private let searchInputView = RMSearchInputView()
    private let noResultsView = RMNoSearchResultsView()
    
    // MARK: - init
    
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(noResultsView, searchInputView)
        addConstraints()
        searchInputView.configure(with: .init(type: viewModel.config.type))
        searchInputView.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Public:
    
    public func presentKeyboard() {
        searchInputView.presentKeyboard()
        
    }
    
    // MARK: - Private:
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            // Input search view
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leftAnchor.constraint(equalTo: leftAnchor),
            searchInputView.rightAnchor.constraint(equalTo: rightAnchor),
            searchInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 55 : 110),
            

            // No result view
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.widthAnchor.constraint(equalToConstant: 150),

            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - extensions

// Delegate
extension RMSearchView: UICollectionViewDelegate {
    
}

// DataSource
extension RMSearchView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// RMSearchInputView Delegate
extension RMSearchView: RMSearchInputViewDelegate {
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        delegate?.rmSearchView(self, didSelectOption: option)
    }
}

