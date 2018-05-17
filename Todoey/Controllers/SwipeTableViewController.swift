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
        //tableView.register(GBTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 60.0
        tableView.separatorStyle = .none
    }
    
    //MARK: - TableView Datasource Methods.
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let localCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GBTableViewCell      ///Get a reusable cell from the tableView.
        
        if localCell.textLabel?.text == nil {   ///cell is new, not dequeued
            //localCell.backgroundColor = UIColor.randomFlat
            //localCell.delegate = self
        }
        
        localCell.textLabel?.backgroundColor = UIColor.clear
        
        return localCell
    }

    
    func updateModel (at indexPath: IndexPath) {
        //Update our data model.
    }

}
