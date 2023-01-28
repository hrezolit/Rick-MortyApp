//
//  RMAPICacheManager.swift
//  Rick&MortyApp
//
//  Created by Nikita on 28/1/23.
//

import Foundation

/// Managing in memory session scope API caching
final class RMAPICacheManager {
    
    private var cacheDictionary: [RMEndpoint : NSCache<NSString, NSData>] = [:]
        
    // MARK: - init
    init() {
        
        setUpCache()
    }
    
    //MARK: - Public:
    public func setCache(for endpoint: RMEndpoint, url: URL?, data: Data) {
        guard
            let targetCache = cacheDictionary[endpoint],
            let url = url
        else { return }
        
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    public func cacheResponse(for endpoint: RMEndpoint, url: URL?) -> Data? {
        guard
            let targetCache = cacheDictionary[endpoint],
            let url = url
        else { return nil }
        
        let key = url.absoluteString as NSString
        
        return targetCache.object(forKey: key) as? Data
    }
    
    //MARK: - Private:
    private func setUpCache() {
        RMEndpoint.allCases.forEach { endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        }
    }
}
