//
//  ViewController.swift
//  Walp
//
//  Created by Ali Safari on 8/23/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let uKey = "0f47e3be92bb69eb63844b988c9c602efb99d314c8664d82e6393642652dfd80"
    let store = PhotoStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        store.searchPhotos()
    }
    
    
    
//    private func fetchReq(for query: String) {
//
//        let uurl = URL(string: "https://api.unsplash.com/search/photos?query=\(query)")
//
//        var gsReq = URLRequest(url: uurl!)
//        gsReq.setValue("Client-ID \(uKey)", forHTTPHeaderField: "Authorization")
//        let gsConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: gsConfig)
//
//        session.dataTask(with: gsReq) { (data, response, error) in
//
//            guard let data = data, error == nil else {
//                print("error**************")
//                DispatchQueue.main.async {
//                }
//                return
//            }
//            print("----------------------------")
//            let jsonString = String(data: data, encoding: .utf8 )
//
//            print(jsonString)
//            DispatchQueue.main.async {
//                do {
//
//                } catch {
//                    print("Error Decoding json__________________")
//                    print(error)
//                }
//            }
//        }.resume()
//    }

    
}

