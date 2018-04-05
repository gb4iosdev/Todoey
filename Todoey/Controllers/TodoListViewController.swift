//
//  ViewController.swift
//  Todoey
//
//  Created by Gavin Butler on 2018-03-31.
//  Copyright © 2018 Gavin Butler. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
        
        //["Find Mike","Buy Eggos","Destroy Demogorgon","Ghost Bust Alien", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
        ///or can use: itemArray = defaults.value(forKey: "TodoListArray") as! Array
            itemArray = items
        }
    }

    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let localCell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]     ///The data item feeding the cell being requested by this call
        
        localCell.textLabel?.text = item.title  ///set the cell text
        
        localCell.accessoryType = item.done ? .checkmark : .none    ///Set the cell checkmark
        
        return localCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        /*let selectedCell = tableView.cellForRow(at: indexPath)!
        if selectedCell.accessoryType == .none {
            selectedCell.accessoryType = .checkmark
        } else {
            selectedCell.accessoryType = .none
        }*/
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.reloadData()
    }

    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the use clicks the 'Add Item' button on the UIAlert
            
            let newItem = Item()
            newItem.title = alert.textFields![0].text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            print(alertTextField.text!)
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    

}

