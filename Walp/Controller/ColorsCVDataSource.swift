//
//  ColorsCVDataSource.swift
//  Walp
//
//  Created by Ali Safari on 2/21/22.
//  Copyright © 2022 Ali Safari. All rights reserved.
//

import UIKit

class ColorsCVDataSource: NSObject, UICollectionViewDataSource {
    
    let colors: [CGColor] = [#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return colors.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
            cell.layer.cornerRadius = 10.0
            cell.layer.backgroundColor = colors[indexPath.item]
            return cell
        }
}
