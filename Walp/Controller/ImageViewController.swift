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
        print("//////Image tapped")
        if navigationController?.navigationBar.alpha == 0 {
            UIView.animate(withDuration: 0.5) {
                self.navigationController?.navigationBar.alpha = 1
                self.imageVCView.setButton.isHidden = false
                self.imageVCView.previewButton.isHidden = false
            }
        }
    }
    
//    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
//        let imageView = sender.view as! UIImageView
//        let newImageView = UIImageView(image: imageView.image)
//        newImageView.frame = UIScreen.main.bounds
//        newImageView.backgroundColor = .blackColor()
//        newImageView.contentMode = .ScaleAspectFit
//        newImageView.userInteractionEnabled = true
//        let tap = UITapGestureRecognizer(target: self, action: "dismissFullscreenImage:")
//        newImageView.addGestureRecognizer(tap)
//        self.view.addSubview(newImageView)
//        self.navigationController?.isNavigationBarHidden = true
//        self.tabBarController?.tabBar.isHidden = true
//    }
//
//    func dismissFullscreenImage(sender: UITapGestureRecognizer) {
//        self.navigationController?.isNavigationBarHidden = false
//        self.tabBarController?.tabBar.isHidden = false
//        sender.view?.removeFromSuperview()
//    }

}
