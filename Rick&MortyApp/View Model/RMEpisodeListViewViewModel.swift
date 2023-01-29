//
//  RMEpisodeListViewViewModel.swift
//  Rick&MortyApp
//
//  Created by Nikita on 29/1/23.
//

import UIKit

protocol RMEpisodeListViewViewModelDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didLoadMoreEpisodes(with newIndexPath: [IndexPath])
    func didSelectEpisode(_ episode: RMEpisode)
}

/// View model to handle episode list view logic
final class RMEpisodeListViewViewModel: NSObject {
    
    public weak var delegate: RMEpisodeListViewViewModelDelegate?
    
    private var isLoadingMoreEpisodes = false
    
    private var episodes: [RMEpisode] = [] {
        didSet{
            for episode in episodes {
                let viewModel = RMCharacterEpisodeCollectionViewCellViewModel(episodeDataURL: URL(string: episode.url)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [RMCharacterEpisodeCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllEpisodesResponse.Info? = nil
    
    /// fetching data for episode list
    public func fetchEpisodeList() {
        
        RMService.shared.execute(
            .listEpisodeRequest,
            expecting: RMGetAllEpisodesResponse.self
        ) { [weak self] result in
            
            switch result {
            case .success(let responseModel):
                
                let results = responseModel.results
                let info = responseModel.info
                self?.episodes = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialEpisodes()
                }
                
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    public func fetchAdditionalEpisode(url: URL) {
        guard !isLoadingMoreEpisodes else { return }
        isLoadingMoreEpisodes = true
        guard
            let request = RMRequest(url: url) else {
            isLoadingMoreEpisodes = false
            return
        }
        
        RMService.shared.execute(
            request,
            expecting: RMGetAllEpisodesResponse.self
        ) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
                
            case .success(let responseModel):
                
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
                
                let originalCount = strongSelf.episodes.count
                let newCount = moreResults.count
                let total = originalCount + newCount
                let startingIndex = total - newCount
                let indexPathToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap {
                    return IndexPath(row: $0, section: 0)
                }
                strongSelf.episodes.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreEpisodes(with: indexPathToAdd)
                    strongSelf.isLoadingMoreEpisodes = false
                }
                
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreEpisodes = false
            }
        }
    }
}

//MARK: - CollectionViewDataSource
extension RMEpisodeListViewViewModel: UICollectionViewDataSource {
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else { fatalError("Unsupported cell")}
        
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
}

//MARK: - CollectionViewDelegate
extension RMEpisodeListViewViewModel: UICollectionViewDelegate {
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let selection = episodes[indexPath.row]
        delegate?.didSelectEpisode(selection)
    }
}

//MARK: - CollectionViewDelegateFlowLayout
extension RMEpisodeListViewViewModel: UICollectionViewDelegateFlowLayout {
    
    // viewForSupplementaryElementOfKind
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard
            kind == UICollectionView.elementKindSectionFooter,
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifire,
                for: indexPath
            ) as? RMFooterLoadingCollectionReusableView
        else {
            fatalError("Unsupported")
        }
        
        footer.startAnimating()
        
        return footer
    }
    
    // referenceSizeForFooterInSection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard shouldShowLoadMoreIndicator else { return .zero}
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    // sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width,
                      height: width * 0.8)
    }
}

// MARK: - UIScrollViewDelegate
extension RMEpisodeListViewViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard
            shouldShowLoadMoreIndicator,
            !isLoadingMoreEpisodes,
            !cellViewModels.isEmpty,
            let nextURL = apiInfo?.next,
            let url = URL(string: nextURL)
        else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewHeght = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewHeght - 120) {
                self?.fetchAdditionalEpisode(url: url)
            }
            t.invalidate()
        }
    }
}
