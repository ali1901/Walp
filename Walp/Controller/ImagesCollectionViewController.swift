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
    var searchQuery = "" {
        didSet {
            navigationItem.title = searchQuery
        }
    }
    let dataSource = CollectionViewDataSource()
    var images = [UIImage]()
    var selecteIP = 0
    var image = UIImage()
    
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    private let itemsPerRow: CGFloat = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
//        self.navigationItem.title = searchQuery
        
        print(searchQuery)
        fetchData()
    }


    // MARK: CollectionViewDelegate methods
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = dataSource.photos[indexPath.item]
        store.fetchImage(for: photo) { (image) in
            guard let photoIndex = self.dataSource.photos.firstIndex(of: photo), case let .success(img) = image else {
                return
            }
            self.images.append(img)
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            OperationQueue.main.addOperation {
                if let cell = collectionView.cellForItem(at: photoIndexPath) as? CustomCollectionViewCell {
                    cell.update(diplaying: img)
                }
            }
        }
        
        if indexPath.row == dataSource.photos.count-1 { //Checking if the last cell is being displayed; calling server for more data
            fetchData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell
        if let img = cell?.imageView.image {
            image = img
        }
        performSegue(withIdentifier: "ShowImage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? ImageViewController {
            nextVC.image = image
        }
    }
    
    // MARK: Custom Functions
    
    private func fetchData() {
        store.searchPhotos(with: searchQuery, orient: true) { (result) in
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
    
    private func fetchImageFromData() {
        
    }
}


extension ImagesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
      let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
      let availableWidth = view.frame.width - paddingSpace
      let widthPerItem = availableWidth / itemsPerRow
      
      return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return sectionInsets.left
    }
}

