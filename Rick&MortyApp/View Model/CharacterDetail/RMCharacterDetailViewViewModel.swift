//
//  RMCharacterDetailViewViewModel.swift
//  Rick&MortyApp
//
//  Created by Nikita on 19/1/23.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    
    enum SectionType {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case information(viewModels: [RMCharacterInfoCollectionViewCellViewModel])
        case episodes(viewModels: [RMCharacterEpisodeCollectionViewCellViewModel])
    }
    
    private let character: RMCharacter
    
    public var episodes: [String] {
        character.episode
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
    public var sections: [SectionType] = []
    
    // MARK: - init
    
    init(character: RMCharacter) {
        self.character = character
        setUpSections()
    }
    
    // MARK: - Public:
 
    public func fetchCharacterData() {
        guard
            let url = requestURL,
            let request = RMRequest(url: url)
        else {
            print("Failed")
            return
        }
        
        RMService.shared.execute(request, expecting: RMCharacter.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    /// Photo's composition layout
    /// - Returns: Photo section
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    
    /// Information's composition layout
    /// - Returns: Two photo's sections
    public func createInformationSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item, item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    
    /// Episode's composition layout
    /// - Returns: Episode's section
    public func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 3, bottom: 5, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    // MARK: - Private:
    
    private func setUpSections() {
        sections = [
            .photo(viewModel: .init(imageURL: URL(string: character.image))),
            
                .information(viewModels: [
                    .init(type: .status, value: character.status.text),
                    .init(type: .gender, value: character.gender.rawValue),
                    .init(type: .type, value: character.type),
                    .init(type: .species, value: character.species),
                    .init(type: .origin, value: character.origin.name),
                    .init(type: .location, value: character.location.name),
                    .init(type: .created, value: character.created),
                    .init(type: .episodeCount, value: "\(character.episode.count)")
                ]),
            
                .episodes(viewModels: character.episode.compactMap ({
                    return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataURL: URL(string: $0))
                }))
        ]
    }
    
    private var requestURL: URL? {
        return URL(string: character.url)
    }
}
