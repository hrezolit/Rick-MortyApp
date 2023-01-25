//
//  RMCharacterDetailViewViewModel.swift
//  Rick&MortyApp
//
//  Created by Nikita on 19/1/23.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    
    private let character: RMCharacter
    
    enum SectionType {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case information(viewModels: [RMCharacterInfoCollectionViewCellViewModel])
        case episodes(viewModels: [RMCharacterEpisodeCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
    // MARK: - init
    init(character: RMCharacter) {
        self.character = character
        setUpSections()
    }
    
    private func setUpSections() {
        sections = [
            .photo(viewModel: .init(imageURL: URL(string: character.image))),
            
                .information(viewModels: [
                    .init(title: "", value: "Status"),
                    .init(title: "", value: "Gender"),
                    .init(title: "", value: "Type"),
                    .init(title: "", value: "Species"),
                    .init(title: "", value: "Origin"),
                    .init(title: "", value: "Location"),
                    .init(title: "", value: "Total Episodes"),
                    .init(title: "", value: "Created")
                ]),
            
                .episodes(viewModels: character.episode.compactMap ({
                    return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataURL: URL(string: $0))
                }))
        ]
    }
    
    private var requsetURL: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
    public func fetchCharacterData() {
        guard
            let url = requsetURL,
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
    
    // MARK: - Photo's composition layout
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
    
    // MARK: - Information's composition layout
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
    
    // MARK: - Episode's composition layout
    public func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.335),
                heightDimension: .absolute(150 )
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
