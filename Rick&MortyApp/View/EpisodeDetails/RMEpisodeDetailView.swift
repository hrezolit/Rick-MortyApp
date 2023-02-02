//
//  RMEpisodeDetailView.swift
//  Rick&MortyApp
//
//  Created by Nikita on 28/1/23.
//

import UIKit

final class RMEpisodeDetailView: UIView {
    
    private var viewModel: RMEpisodeDetailViewViewModel? {
        didSet {
            spinner.stopAnimating()
            self.collectionView?.reloadData()
            self.collectionView?.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.alpha = 1
            }
        }
    }
    
    private var collectionView: UICollectionView?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        
        return spinner
    }()
    
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        let collectionView = createCollectionView()
        addSubviews(collectionView, spinner)
        self.collectionView =  collectionView
        addConstraints()
        
        spinner.startAnimating()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public:
    
    public func configure(with viewModel: RMEpisodeDetailViewViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Private:
    
    private func addConstraints() {
        guard let collectionView else { return }
        
        NSLayoutConstraint.activate([
            
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.layout(for: section)
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // episodes cell
        collectionView.register(RMEpisodeInfoCollectionViewCell.self, forCellWithReuseIdentifier: RMEpisodeInfoCollectionViewCell.cellIdentifier)
        // characters cell
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        
        return collectionView
    }
}

// MARK: - extensions:

// layouts
extension RMEpisodeDetailView {
    
     func layout(for section: Int) -> NSCollectionLayoutSection {
         
         guard let sections = viewModel?.cellViewModels else { return createInfoLayout()}
         
         switch sections[section] {
         case .information:
             return createInfoLayout()
         case .characters:
             return createCharacterLayout()
         
         }
    }
    
    // create information layout
    func createInfoLayout() -> NSCollectionLayoutSection {

        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(100)),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    // create characters layout
    func createCharacterLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1))
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(240)),
            subitems: [item, item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}

// delegate
extension RMEpisodeDetailView: UICollectionViewDelegate {
    
}

// datasource
extension RMEpisodeDetailView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = viewModel?.cellViewModels else { return 0 }
        let sectionType = sections[section]
        switch sectionType {
        case .information(let viewModels):
            return viewModels.count
        case .characters(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sections = viewModel?.cellViewModels else { fatalError("No view model, location: RMEpisodeDetailView -> cellForItemAt") }
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
            
            // information case
        case .information(let viewModels):
            
            let viewModelCell = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMEpisodeInfoCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? RMEpisodeInfoCollectionViewCell else { fatalError()}
            
            cell.configure(with: viewModelCell)
            
            return cell
            
            // character case
        case .characters(let viewModels):
            
            let viewModelCell = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? RMCharacterCollectionViewCell else { fatalError()}
            
            cell.configure(with: viewModelCell)
            
            return cell
            
        }
    }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
