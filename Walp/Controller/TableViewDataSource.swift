//
//  TableViewDataSource.swift
//  Walp
//
//  Created by Ali Safari on 10/18/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    var photos = [Photo]() {
        didSet {
            print("New Element------------------:\(photos.last!.id)")
        }
    }
    var cats = ["Snow", "Nature", "Night Sky", "Sunflower", "Sports"]

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > photos.count-1 {
            return UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
            cell.titleLabel.text = cats[indexPath.row]
            
            cell.update(displaying: nil)
            return cell
        }
    }
    
}
