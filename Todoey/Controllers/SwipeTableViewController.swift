//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Gavin Butler on 2018-04-14.
//  Copyright © 2018 Gavin Butler. All rights reserved.
//

import UIKit
import ChameleonFramework

class SwipeTableViewController: UITableViewController {
    
    var italicTextHeight: CGFloat = 20.0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }
    
    //MARK: - TableView Datasource Methods.
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let localCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //as! SwipeTableViewCell      ///Get a reusable cell from the tableView.
        
        if localCell.textLabel?.text == nil {   ///cell is new, not dequeued
            //localCell.backgroundColor = UIColor.randomFlat
            //localCell.delegate = self
        }
        
        
        
        return localCell
    }

    
    func updateModel (at indexPath: IndexPath) {
        //Update our data model.
    }

}
