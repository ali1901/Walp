//
//  CollectionViewDataSource.swift
//  Walp
//
//  Created by Ali Safari on 10/19/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var photos = [Photo]() {
        didSet {
            print("data on collectionViewDS set:---------\(photos.count)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of items is: ",photos.count)
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = "CVCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CustomCollectionViewCell
//        cell.contentView.layer.cornerRadius = 10.0
        cell.layer.cornerRadius = 10.0
        cell.layer.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        cell.update(diplaying: nil)
        return cell
    }
    
    
}
