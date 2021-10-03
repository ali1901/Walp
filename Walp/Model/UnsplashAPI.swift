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
    
    private static func unsplashURL(endPoint: endPoint, parameters: [String:String]?) -> URL {
        var components = URLComponents(string: baseUrlString)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = ["Authorization":theKEY, "orientation":"portrait"]
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
}
