//
//  TableViewDataSource.swift
//  Walp
//
//  Created by Ali Safari on 10/18/21.
//  Copyright © 2021 Ali Safari. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    var photos = [Photo]()
    var cats = ["Snow", "Nature", "Night Sky", "Sunflower", "Sports", "Sea", "Jungle", "Mountain", "Beach", "City", "Car"]
    let ds = ColorsCVDataSource()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cats.count
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Categories"
        default:
            return "Colors"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > photos.count-1 {
            return UITableViewCell()
        } else {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
                cell.titleLabel.text = cats[indexPath.row]
                cell.layer.cornerRadius = 15.0
                cell.layer.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
                cell.update(displaying: nil)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "colorsCell", for: indexPath) as! TableViewCellWithCollectionView
                cell.colorsCollectionView.dataSource = ds
                return cell
            }
            
        }
    }
    
}
