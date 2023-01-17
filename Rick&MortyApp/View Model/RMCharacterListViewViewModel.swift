//
//  CharacterListViewViewModel.swift
//  Rick&MortyApp
//
//  Created by Nikita on 16/1/23.
//

import UIKit

final class RMCharacterListViewViewModel: NSObject {
    
    /// fetching data for character list
    func fetchCharacterList() {
        
        RMService.shared.execute(.listCharacterRequest, expecting: RMGetAllCharactersResponse.self) { result in
            
            switch result {
            case .success(let model):
                print("Total: "+String(model.results.first?.image ?? "No Image"))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

//MARK: - CollectionViewDataSource
extension RMCharacterListViewViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else { fatalError("Unsupported cell")}
        
        let viewModel = RMCharacterCollectionViewCellViewModel(characterName: "Nik", characterStatus: .alive, characterImageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/13.jpeg"))
        
        cell.configure(with: viewModel)
        return cell
    }
}

//MARK: - CollectionViewDelegate
extension RMCharacterListViewViewModel: UICollectionViewDelegate {
    
}

//MARK: - CollectionViewDelegateFlowLayout
extension RMCharacterListViewViewModel: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width,
                      height: width * 1.5)
    }
}
