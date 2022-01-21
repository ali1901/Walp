//
//  TableViewDataSource.swift
//  Walp
//
//  Created by Ali Safari on 10/18/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    var fetchedResponseArray = [[Int:Photo]]() {
        didSet {
            for item in fetchedResponseArray {
                print(item.keys.description)
            }
            print("Got data successfully------------------")
            //Mark - TO DO: Sorting the fetchedarray
            fetchedResponseArray.sort{$0.keys.description < $1.keys.description}
            for i in fetchedResponseArray.indices {
                let value = fetchedResponseArray[i]
                print(value.keys.description)
                DispatchQueue.main.async {
                    if let p = value[i] {
                        self.photos.append(p)
                    }
                }
            }
        }
    }
    
    var photos = [Photo]() {
        didSet {
            
        }
    }
    var cats = ["Snow", "Nature", "Night Sky", "Sunflower", "Sports", "Sea", "Jungle", "Mountain", "Beach", "City", "Car"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > photos.count-1 {
            return UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
            cell.titleLabel.text = cats[indexPath.row]
            cell.layer.cornerRadius = 15.0
            cell.layer.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            cell.update(displaying: nil)
            return cell
        }
    }
    
}
