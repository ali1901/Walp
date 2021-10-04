//
//  PhotoStore.swift
//  Walp
//
//  Created by Ali Safari on 10/4/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import Foundation

class PhotoStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    public func searchPhotos() {
        let url = UnsplashAPI.searchQuery(query: "tenet")
        var request = URLRequest(url: url)
        request.setValue(UnsplashAPI.theKEY, forHTTPHeaderField: "Authorization")
//        request.setValue("tenet", forHTTPHeaderField: "query")
        let task = session.dataTask(with: request) {(data, response, error) in
            if let jsonData = data {
                let jsonString = String(data: jsonData, encoding: .utf8)
                print(jsonString)
                print("-----------------------------")
                print(jsonData.description)
            } else if let reqError = error {
                print("Error fetching data from server: \(reqError)")
            } else {
                print("Unexpected Error!")
            }
        }
        task.resume()
    }
}
