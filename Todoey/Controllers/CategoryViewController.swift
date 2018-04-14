//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Gavin Butler on 10-04-2018.
//  Copyright © 2018 Gavin Butler. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit


class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.rowHeight = 80.0
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let localCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell      ///Get a reusable cell from the tableView.
        
        if categories!.count > 0 {
            localCell.textLabel?.text = categories?[indexPath.row].name  ///set the cell text
        } else {
            localCell.textLabel?.text = "No Categories Added Yet"
        }
        
        localCell.delegate = self
        
        return localCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numRows = categories?.count {
            return numRows > 0 ? numRows : 1
        } else {
            return 1
        }
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ///Must have only one "goToItems" segue here, otherwise would check for identifier with 'if' statement
            
        let destinationVC = segue.destination as! TodoListViewController
        
        ///But how to get the indexPath here while we're preparing for Segue?
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete && categories?[indexPath.row] != nil {
//            do {
//                try realm.write {
//                    for eachItem in categories![indexPath.row].items {
//                        realm.delete(eachItem)
//                    }
//                    realm.delete(categories![indexPath.row])
//                }
//            } catch {
//                print("Error deleting category: \(error)")
//            }
//            tableView.reloadData()
//        }
//    }

    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //What will happen once the use clicks the 'Add Item' button on the UIAlert
            
            let newCategory = Category()
            newCategory.name = alert.textFields![0].text!
            
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            print(alertTextField.text!)
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)

        tableView.reloadData()
    }
}

//MARK: - Swipe Cell Delegate Methods

extension CategoryViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            if let categoryForDeletion = self.categories?[indexPath.row] {
                do {
                    try self.realm.write {
                        for eachItem in categoryForDeletion.items {
                            self.realm.delete(eachItem)
                        }
                        self.realm.delete(categoryForDeletion)
                    }
                } catch {
                    print("Error deleting category: \(error)")
                }
                //tableView.reloadData()
            }
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }

}
