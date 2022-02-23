//
//  ColorsCVDataSource.swift
//  Walp
//
//  Created by Ali Safari on 2/21/22.
//  Copyright © 2022 Ali Safari. All rights reserved.
//

import UIKit

class ColorsCVDataSource: NSObject, UICollectionViewDataSource {
    
    let colorStrings = ["black and white", "yellow", "orange", "red", "purple", "blue", "green", "teal", "magnetta"]
    let colors: [CGColor] = [#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), #colorLiteral(red: 0.9135910869, green: 0.4319670498, blue: 0.2083321512, alpha: 1), #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0.4549019608, green: 0.07450980392, blue: 0.4156862745, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.08235294118, green: 0.5725490196, blue: 0.5921568627, alpha: 1), #colorLiteral(red: 0.862745098, green: 0, blue: 0.7607843137, alpha: 1)]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return colors.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
            cell.layer.cornerRadius = 15.5
            cell.layer.backgroundColor = colors[indexPath.item]
            return cell
        }
}
