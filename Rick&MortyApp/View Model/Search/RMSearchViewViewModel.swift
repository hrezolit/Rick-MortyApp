//
//  RMSearchViewViewModel.swift
//  Rick&MortyApp
//
//  Created by Nikita on 8/2/23.
//

import Foundation

final class RMSearchViewViewModel {
    
    let config: RMSearchViewController.Config
    
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption : String] = [:]
    private var optionMapUpdateBlock: (((RMSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    private var searchText = ""
    private var searchResultHandler: (() -> Void)?
    //MARK: - init
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    //MARK: - Public
    
    public func registerSearchResultHandler(_ block: @escaping () -> Void) {
        self.searchResultHandler = block
    }
    
    public func executeSearch() {
        
        // Configure arguments
        var queryParams: [URLQueryItem] = [URLQueryItem(name: "name", value: searchText)]
        
        // Add option
        queryParams.append(contentsOf: optionMap.enumerated().compactMap({ _, element in
            let key: RMSearchInputViewViewModel.DynamicOption = element.key
            let value: String = element.value
            
            return URLQueryItem(name: key.queryArgument, value: value)
        }))
        
        // Create request
        let request = RMRequest(endPoint: config.type.endpoint,
                                queryParameters: queryParams)
        
        RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print ("Search results found: \(model.results.count)")
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    
    public func set(query text: String) {
        self.searchText = text
    }
    
    public func set(value: String, for option: RMSearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((RMSearchInputViewViewModel.DynamicOption, String)) -> Void) {
        
        self.optionMapUpdateBlock = block
    }
}
