//
//  UnsplashAPI.swift
//  Walp
//
//  Created by Ali Safari on 10/3/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import Foundation

enum endPoint: String {
    case search = "search"
    case random = "random"
}

struct UnsplashAPI {
    private static let baseUrlString = "https://api.unsplash.com"
    private static let apiKey = "0f47e3be92bb69eb63844b988c9c602efb99d314c8664d82e6393642652dfd80"
    static let theKEY = "Client-ID 0f47e3be92bb69eb63844b988c9c602efb99d314c8664d82e6393642652dfd80"
    private static var queryToSearch = ""
    
    private static func unsplashURL(endPoint: endPoint, parameters: [String:String]?) -> URL {
        var bu = ""
        
        switch endPoint {
        case .random:
            bu = baseUrlString + "/photos/random"
        case .search:
            bu = baseUrlString + "/search/photos"
        }
        
        var components = URLComponents(string: bu)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = ["orientation":"portrait"]
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        return components.url!
    }
    
    public static func searchQuery(query: String) -> URL {
        queryToSearch = query
        return searchPhotoURL
    }
    private static var searchPhotoURL: URL {
        return unsplashURL(endPoint: .search, parameters: ["query":queryToSearch])
    }
    
    static var randomPhotoURL: URL {
        return unsplashURL(endPoint: .random, parameters: nil)
    }
}
