//
//  ImagesCollectionViewController.swift
//  Walp
//
//  Created by Ali Safari on 10/16/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ImagesCollectionViewController: UICollectionViewController {
    
    private let store = PhotoStore()
    var searchQuery = ""
    let dataSource = CollectionViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        print(searchQuery)
        store.searchPhotos(with: searchQuery) { (result) in
            switch result {
            case let .success(photo):
                self.dataSource.photos.append(contentsOf: photo)
            case let .failure(error):
                print("Couldn't get the images for you: \(error)")
            }
            OperationQueue.main.addOperation {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = dataSource.photos[indexPath.item]
        store.fetchImage(for: photo) { (image) in
            guard let photoIndex = self.dataSource.photos.firstIndex(of: photo), case let .success(img) = image else {
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            OperationQueue.main.addOperation {
                if let cell = collectionView.cellForItem(at: photoIndexPath) as? CustomCollectionViewCell {
                    cell.update(diplaying: img)
                }
            }
        }
    }

}
