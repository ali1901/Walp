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
    var cats = ["Snow", "Nature", "Night Sky", "Sunflower", "Sports"]
    var photos = [Photo]()
    var img = UIImage() {
        didSet {
            print("Ime set brooooooooooooo")
        }
    }
    var fetchedImages = [UIImage]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        store.searchPhotos(with: "Nature") { (photoResults) in
            switch photoResults {
            case let .success(photo):
                print("Succsefullt found \(photo[0].urls.full)")
                self.photos.append(contentsOf: photo)
                self.store.fetchImage(for: self.photos.first!) { (imgRes) in
                    switch imgRes {
                    case let .success(img):
                        OperationQueue.main.addOperation {
                            self.img = img
                            print("Image set'//'/'/'/'/'/'/'/'/'/'/'/'/'/'/'/")
                            self.tableView.reloadData()
                        }
                        self.img = img
                    case let .failure(err):
                        print ("Could not fetch the image.: \(err)")
                    }
                }

            case let .failure(error):
                print("Couldn't find any photos: \(error)")
            }
        }
        for item in photos {
            print("Avalible \(item.id)")
        }
        
//        store.fetchImage(for: photos.first!) { (imgRes) in
//            switch imgRes {
//            case let .success(img):
//                self.img = img
//            case let .failure(err):
//                print ("Could not fetch the image.: \(err)")
//            }
//        }
    }

    
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.titleLabel.text = cats[indexPath.row]
        OperationQueue.main.addOperation {
            cell.cellBackgroundImage.image = self.img
        }
        
        return cell
    }
    
    //cell.cellBackgroundImage.image =
}

