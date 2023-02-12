//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  Rick&MortyApp
//
//  Created by Nikita on 24/1/23.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel {
    
    private let imageURL: URL?
    
    // MARK: - init
    
    init(imageURL: URL?) {
        
        self.imageURL = imageURL
    }
    
    // MARK: - Public:
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let imageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        RMImageManager.shared.downloadImage(imageURL, completion: completion)
    }
}
