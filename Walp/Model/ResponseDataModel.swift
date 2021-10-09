//
//  ResponseDataModel.swift
//  Walp
//
//  Created by Ali Safari on 10/4/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import Foundation

//struct SuccessResponse: Codable {
//    let result: Results
//}

struct Results: Codable {
    var total: Int
    var results: [Result]
}

struct Result: Codable {
    var id: String
    var urls: Urls
    var description: String?
}

struct Urls: Codable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
}

