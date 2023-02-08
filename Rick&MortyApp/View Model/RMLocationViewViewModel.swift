//
//  RMLocationViewViewModel.swift
//  Rick&MortyApp
//
//  Created by Nikita on 8/2/23.
//

import Foundation

final class RMLocationViewViewModel {
    
    private var locations: [RMLocation] = []
    
    private var cellViewModels: [String] = []
    
    init() {
        
    }
    
    public func fetchLoactions() {
        RMService.shared.execute(.listLocationsRequest, expecting: String.self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
