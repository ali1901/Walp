//
//  PhotoStore.swift
//  Walp
//
//  Created by Ali Safari on 10/4/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import Foundation
import UIKit

class PhotoStore {
    
    var results = [Photo]() {
        didSet {
            for item in results {
                print("Item availibe: \(item)")
            }
        }
    }
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    public func searchPhotos(with query: String, orient: Bool, compleition: @escaping (Result<[Photo], Error>) -> Void) {
        let url = UnsplashAPI.searchQuery(query: query, orient: orient)
        var request = URLRequest(url: url)
        request.setValue(UnsplashAPI.theKEY, forHTTPHeaderField: "Authorization")
        let task = session.dataTask(with: request) {(data, response, error) in
            
            let results = self.processPhotosRequest(with: data, error: error)
            compleition(results)
        }
        task.resume()
    }
    
    private func processPhotosRequest(with data: Data?, error: Error?) -> Result<[Photo], Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return UnsplashAPI.photos(from: jsonData)
    }
    
    public func fetchImage(for photo: Photo, with compelition: @escaping (Result<UIImage, Error>) -> Void) {
      
        let imageUrl = URL(string: photo.urls.full)
        let request = URLRequest(url: imageUrl!)
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processImageRequest(data: data, error: error)
            compelition(result)
        }
        task.resume()
    }
    
    private func processImageRequest(data: Data?, error: Error?) -> Result<UIImage, Error> {
        guard let imageData = data, let image = UIImage(data: imageData) else {
            return .failure(error!)
        }
        return .success(image)
    }
}
