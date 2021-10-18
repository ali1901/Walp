//
//  ResponseDataModel.swift
//  Walp
//
//  Created by Ali Safari on 10/4/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import Foundation

struct Response: Codable {
    var total: Int
    var results: [Photo]
}

struct Photo: Codable, Equatable {
    var id: String
    var urls: Urls
    var description: String?
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Urls: Codable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
}

