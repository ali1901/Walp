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
    var searchQuery = ""
    var photos = [Photo]()
    var images = [UIImage]()
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

//        for item in cats {
            store.searchPhotos(with: "snow") { (photoResults) in
                switch photoResults {
                case let .success(photo):
                    print("Succsefullt found \(photo[0].urls.full)")
                    self.photos.append(contentsOf: photo)
                    self.store.fetchImage(for: self.photos.first!) { (imgRes) in
                        switch imgRes {
                        case let .success(img):
                            OperationQueue.main.addOperation {
                                self.img = img
                                self.images.append(img)
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
//        }
        for item in photos {
            print("Avalible \(item.id)")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showImages":
            if let nvc = segue.destination as? ImagesCollectionViewController {
                nvc.searchQuery = self.searchQuery
            }
        default:
            if let nvc = segue.destination as? ImagesCollectionViewController {
                nvc.searchQuery = "taxi"
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchQuery = cats[indexPath.row]
    }
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

