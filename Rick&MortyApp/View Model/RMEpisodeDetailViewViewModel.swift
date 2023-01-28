//
//  RMEpisodeDetailViewViewModel.swift
//  Rick&MortyApp
//
//  Created by Nikita on 28/1/23.
//

import UIKit

final class RMEpisodeDetailViewViewModel {
    
    private let endpointURL: URL?
    
    init(endpointURL: URL?) {
        self.endpointURL = endpointURL
        fetchEpisodeData()
    }
    
    private func fetchEpisodeData() {
        
        guard
            let url = endpointURL,
            let request = RMRequest(url: url)
        else { return }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                print(String(describing: failure))
                break
            }
        }
    }
}
