//
//  ViewController.swift
//  Walp
//
//  Created by Ali Safari on 8/23/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let store = PhotoStore()
    let tableViewDataSource = TableViewDataSource()
    var cats = ["Snow", "Nature", "Night Sky", "Sunflower", "Sports", "Sea", "Jungle", "Mountain", "Beach", "City", "Car"]

    let dispatchGroup = DispatchGroup()
    var fetchedResponse = [Int:Photo]() {
        didSet {
            if fetchedResponse.count == cats.count {

                let sorted = fetchedResponse.sorted { (a, b) -> Bool in
                    a.key < b.key
                }
                
                for i in 0..<sorted.count {
                    let v = sorted[i]
                    self.tableViewDataSource.photos.append(v.value)
                }
                self.dispatchGroup.notify(queue: .main) {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
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
        for i in 0..<cats.count {
            self.fetchData(searchTerm: self.cats[i], index: i)
        }
    }
    
    private func fetchData(searchTerm: String, index: Int) {
        dispatchGroup.enter() //USED for adding concurrency to fetching data when calling this func multiple times
        store.searchPhotos(with: searchTerm, orient: false) { (photoResults) in
            switch photoResults {
            case let .success(photos):
                OperationQueue.main.addOperation {
                    self.fetchedResponse[index] = photos[0]
                    self.dispatchGroup.leave() //USED for adding concurrency to fetching data when calling this func multiple times
                }
            case let .failure(error):
                print("no photos were found: \(error)")
                self.tableViewDataSource.photos.removeAll()
            }
        }
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
        
        if self.tableViewDataSource.photos.count > 0 {

            let photo = self.tableViewDataSource.photos[indexPath.row]
            self.store.fetchImage(for: photo) { (result) in
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        self.searchQuery = cats[indexPath.item]
        self.performSegue(withIdentifier: "showImages", sender: self)
    }
}


