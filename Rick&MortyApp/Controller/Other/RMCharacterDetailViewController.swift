//
//  RMCharacterDetailViewController.swift
//  Rick&MortyApp
//
//  Created by Nikita on 19/1/23.
//

import UIKit

/// Controller for showing selected character info
final class RMCharacterDetailViewController: UIViewController {
    
    private let viewModel: RMCharacterDetailViewViewModel
    
    private let detailView: RMCharacterDetailView
    
    // MARK: - init:
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare)
        )
        addConstraints()
        
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    
    @objc private func didTapShare() {
        
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

// MARK: - Collection View Delegate
extension RMCharacterDetailViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
}

// MARK: - Collection View Data Source
extension RMCharacterDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionTypes = viewModel.sections[section]
        switch sectionTypes {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterPhotoCollectionViewCell else {
                fatalError("Something goes wrong")
            }
            cell.configure(with: viewModel)
            return cell
            
        case .information(let viewModels):
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterInfoCollectionViewCell else {
                fatalError("Something goes wrong")
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
            
        case .episodes(let viewModels):
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
                fatalError("Something goes wrong")
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]

        switch sectionType {
        case .photo, .information:
            break
        case .episodes(_):
            let episodes = self.viewModel.episodes
            let selection = episodes[indexPath.row]
            let vc = RMEpisodeDetailViewController(url: URL(string: selection))
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

