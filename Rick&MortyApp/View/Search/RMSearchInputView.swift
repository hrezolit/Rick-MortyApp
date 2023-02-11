//
//  RMSearchInputView.swift
//  Rick&MortyApp
//
//  Created by Nikita on 8/2/23.
//

import UIKit

/// Main view for searching
final class RMSearchInputView: UIView {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search..."
        
        return searchBar
    }()
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemMint
        addSubviews(searchBar)
        addConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public:
    
    public func configure(with viewModel: RMSearchViewViewModel) {
        
    }
    
    // MARK: - Private:
    
    private  func addConstraints() {
        NSLayoutConstraint.activate([
        
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            searchBar.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
