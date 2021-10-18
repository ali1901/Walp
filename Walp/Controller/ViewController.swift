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
    let tableViewDataSource = TableViewDataSource()
    var cats = ["Snow", "Nature", "Night Sky", "Sunflower", "Sports"]
    var searchQuery = ""
    var photos = [Photo]()
    var images = [UIImage]() {
        didSet {
            print("We're settttt brooooooo////////")
        }
    }
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

        tableView.dataSource = tableViewDataSource
        for i in 0..<cats.count {
            print(i, "----")
            store.searchPhotos(with: cats[i]) { (photoResults) in
                switch photoResults {
                case let .success(photo):
                    print("Succsefullt found \(photo[0].urls.full)")
                    self.photos.append(photo[0])
                    self.tableViewDataSource.photos.append(photo[0])
//                    self.tableView.reloadData()
                    print(i," ------ ",self.photos.count)
//                    self.store.fetchImage(for: self.photos[i]) { (imgRes) in
//                        switch imgRes {
//                        case let .success(img):
//                            OperationQueue.main.addOperation {
//                                self.img = img
//                                self.images.append(img)
//                                print("Image set'//'/'/'/'/'/'/'/'/'/'/'/'/'/'/'/")
//                                self.tableView.reloadData()
//                            }
//                            self.img = img
//                        case let .failure(err):
//                            print ("Could not fetch the image.: \(err)")
//                        }
//                    }
                    
                case let .failure(error):
                    print("Couldn't find any photos: \(error)")
                    self.tableViewDataSource.photos.removeAll()
                }
                OperationQueue.main.addOperation {
//                    self.tableView.reloadSections(IndexSet(integer: 0), with: UITableView.RowAnimation.fade)
                    self.tableView.reloadData()
                }
                
            }
        }
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let photo = tableViewDataSource.photos[indexPath.row]
        store.fetchImage(for: photo) { (result) in
            guard let photoIndex = self.tableViewDataSource.photos.firstIndex(of: photo),
                case let .success(image) = result else {
                    return
            }
            let photoIndexPath = IndexPath(row: photoIndex, section: 0)
            
            if let cell = self.tableView.cellForRow(at: photoIndexPath) as? CustomTableViewCell {
                cell.update(displaying: image)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchQuery = cats[indexPath.row]
    }
}


