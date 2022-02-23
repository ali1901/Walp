//
//  ColorCVDelegate.swift
//  Walp
//
//  Created by Ali Safari on 2/22/22.
//  Copyright © 2022 Ali Safari. All rights reserved.
//

import UIKit

class ColorCVDelegate: NSObject, UICollectionViewDelegate {
    
    private let sectionInsets = UIEdgeInsets(top: 2.0, left: 10.0, bottom: 2.0, right: 10.0)
    private let itemsPerRow: CGFloat = 2
    
    var selectedColor = ""
    let notificatioName = "ColorPicked"
    var userInfo: [String:String] = ["selectedColor":""]
    let colorStrings = ["black and white", "yellow", "orange", "red", "purple", "blue", "green", "teal", "magnetta"]

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColor = colorStrings[indexPath.item]
        userInfo["selectedColor"] = selectedColor
        let name = Notification.Name(notificatioName)
        NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo) //Posting a notification regarding the selected color. The observer is in ViewController.
    }
    

}

extension ColorCVDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
      let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//      let availableWidth = view.frame.width - paddingSpace
      let widthPerItem = paddingSpace + itemsPerRow
      
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return sectionInsets.left
    }
}
