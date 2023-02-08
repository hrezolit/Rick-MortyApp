//
//  RMSearchView.swift
//  Rick&MortyApp
//
//  Created by Nikita on 8/2/23.
//

import UIKit

final class RMSearchView: UIView {

    private let viewModel: RMSearchViewViewModel
    
    // MARK: - init
    
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .orange
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
