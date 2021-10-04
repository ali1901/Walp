//
//  ResponseDataModel.swift
//  Walp
//
//  Created by Ali Safari on 10/4/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import Foundation

struct SuccessResponse {
    let result: Result
}

struct Results {
    let results: [Result]
}

struct Result {
    let id: String
    let urls: Urls
}

struct Urls {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
