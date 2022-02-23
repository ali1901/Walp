//
//  CustomCollectionViewCell.swift
//  Walp
//
//  Created by Ali Safari on 10/19/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func update(diplaying image: UIImage?) {
        if let img = image {
            spinner.stopAnimating()
            spinner.isHidden = true
            OperationQueue.main.addOperation {
                self.imageView.image = img
            }
        } else {
            spinner.isHidden = false
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
}
