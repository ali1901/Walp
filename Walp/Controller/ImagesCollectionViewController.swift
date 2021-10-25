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
    
    private let sectionInsets = UIEdgeInsets(
    top: 10.0,
    left: 20.0,
    bottom: 50.0,
    right: 20.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        print(searchQuery)
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
    
    override func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("did reach to the topppppppp----------")
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            //reach bottom
            print("did reach to the topppppppp----------") //Gets called many times
//            store.searchPhotos(with: searchQuery, orient: true) { (result) in
//                switch result {
//                case let .success(photo):
//                    self.dataSource.photos.append(contentsOf: photo)
//                case let .failure(error):
//                    print("Couldn't get the images for you: \(error)")
//                }
//                OperationQueue.main.addOperation {
//                    self.collectionView.reloadData()
//                }
//            }
        }

        if (scrollView.contentOffset.y < 0){
            //reach top
        }

        if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){
            //not top and not bottom
        }
    }

}


extension ImagesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
      let paddingSpace = sectionInsets.left * 3
      let availableWidth = view.frame.width - paddingSpace
      let widthPerItem = availableWidth / 2
      
      return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return sectionInsets.left
    }
}

