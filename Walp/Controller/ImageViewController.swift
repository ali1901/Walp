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
    
    var image = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageVCView.imageView.image = image
    }
    
    @IBAction func setAsWalp(sender: UIButton) {
        //Set the image as wallpaper
        print("Image set as walp")
    }

}
