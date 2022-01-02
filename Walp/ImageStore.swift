//
//  ImageStore.swift
//  MDB
//
//  Created by Ali Safari on 9/14/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import UIKit

class ImageStore {
    let cache = NSCache<NSString, UIImage>()
    
    func setImage( _ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        
        if let data = image.jpegData(compressionQuality: 0.5) {
            do {
                try data.write(to: url)
//                print("image saved successfully in : \(url)")
            } catch {
                print("Unable to save the image: \(error)")
            }
        }
    }
    
    func image(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }

        let url = imageURL(forKey: key)
        var data = Data()
        do {
            data = try Data(contentsOf: url)
        } catch {
            print("Error Loading the image data: \(error)")
        }
        guard let imageFromDisk = UIImage(data: data) else {
            return nil
        }
//        print("getting image from: \(url)")
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
     
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Error removing image from disk: \(error)")
        }
    }
    
    func imageURL(forKey key: String) -> URL {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectory = documentDirectories.first!
        return docDirectory.appendingPathComponent("\(key).jpeg")
    }
}
