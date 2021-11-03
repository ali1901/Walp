//
//  ImageViewController.swift
//  Walp
//
//  Created by Ali Safari on 10/26/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    public var imageVCView: ImageVCView! {
        guard isViewLoaded else {
            return nil
        }
        return (view as! ImageVCView)
    }
    let fullScreenPhoto = UIImageView()
    
    var image = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        imageVCView.addSubview(fullScreenPhoto)
        // Do any additional setup after loading the view.
        imageVCView.imageView.image = image
    }
    
    @IBAction func setAsWalp(sender: UIButton) {
        //Set the image as wallpaper
        print("Image set as walp")
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    @IBAction func preview(sender: UIButton) {
        
        UIView.animate(withDuration: 0.5) {
            self.navigationController?.navigationBar.alpha = 0
            self.imageVCView.setButton.isHidden = true
            self.imageVCView.previewButton.isHidden = true
        }
    }
    
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        
        if navigationController?.navigationBar.alpha == 0 {
            UIView.animate(withDuration: 0.5) {
                self.navigationController?.navigationBar.alpha = 1
                self.imageVCView.setButton.isHidden = false
                self.imageVCView.previewButton.isHidden = false
            }
        }
    }

}
