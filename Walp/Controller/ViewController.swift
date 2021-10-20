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
    var images = [UIImage]()
    
    var img = UIImage()
    var fetchedImages = [UIImage]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tableView.dataSource = tableViewDataSource
//        for i in 0..<cats.count {
//            print(i, "----")
            store.searchPhotos(with: cats[1]) { (photoResults) in
                switch photoResults {
                case let .success(photo):
                    print("Succsefullt found \(photo[0].id)")
//                    self.photos.append(contentsOf: photo)
                    self.tableViewDataSource.photos.append(contentsOf: photo)
                    print(" ------ ",self.photos.count)
                case let .failure(error):
                    print("Couldn't find any photos: \(error)")
                    self.tableViewDataSource.photos.removeAll()
                }
                OperationQueue.main.addOperation {
//                    self.tableView.reloadSections(IndexSet(integer: 0), with: UITableView.RowAnimation.fade)
                    self.tableView.reloadData()
                }
                
            }
//        }
//        for item in photos {
//            print("Avalible \(item.id)")
//        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showImages":
            if let nvc = segue.destination as? ImagesCollectionViewController {
                nvc.searchQuery = searchQuery
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
            
            OperationQueue.main.addOperation{
                if let cell = self.tableView.cellForRow(at: photoIndexPath) as? CustomTableViewCell {
                    cell.update(displaying: image)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("-----------------\(indexPath.item): \(cats[indexPath.item])")
        
        self.searchQuery = cats[indexPath.item]
        self.performSegue(withIdentifier: "showImages", sender: self)
    }
}


