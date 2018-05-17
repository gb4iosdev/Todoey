//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Gavin Butler on 10-04-2018.
//  Copyright © 2018 Gavin Butler. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    var addedCellRow: Int?              ///The row of the most recently added cell, for animation
    var viewHasLoaded = false     ///For cascade animation on initial load

    override func viewDidLoad() {
        super.viewDidLoad()
        //loadCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadCategories()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewHasLoaded = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ///Don't re-do on-start animation
        viewHasLoaded = true
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! GBTableViewCell
        if !categories!.isEmpty  {     //let cat = categories?[indexPath.row],
            let cat = categories![indexPath.row]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
            cell.textLabel?.text = cat.name  ///set the cell text
            cell.backgroundColor = HexColor((cat.bgColour)) ///set the background colour
            cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: cell.backgroundColor!, isFlat: true)    ///set a contrasting text colour
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14.0)
            let subTitleTrailingText = cat.items.count == 1 ? "item" : "items"
            cell.detailTextLabel?.text = "\(categories?[indexPath.row].items.count ?? 0) \(subTitleTrailingText)"
            cell.detailTextLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: cell.backgroundColor!, isFlat: true)    ///set a contrasting text colour for subtitle
            if !viewHasLoaded {
                animateIn(cell: cell, withDelay: 0.15 * Double(indexPath.row))
            }
            if addedCellRow != nil && indexPath.row == addedCellRow {
                animateIn(cell: cell, withDelay: 0.2)
                addedCellRow = nil
            }
        } else {
            cell.textLabel?.font = UIFont.italicSystemFont(ofSize: italicTextHeight)
            cell.textLabel?.textColor = UIColor.lightGray
            cell.textLabel?.text = "Tap to add new category"
            animateIn(cell: cell, withDelay: 0.0)
        }
        
        return cell
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
            //if categories!.count > 0 {
                destinationVC.selectedCategory = categories?[indexPath.row]
            //}
        }
    }

    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //What will happen once the use clicks the 'Add Item' button on the UIAlert
            
            let newCategory = Category()
            newCategory.name = alert.textFields![0].text!
            newCategory.bgColour = UIColor.randomFlat.hexValue()
            
            self.addedCellRow = self.categories?.count
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
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try realm.write {
                    for eachItem in categoryForDeletion.items {
                        realm.delete(eachItem)
                    }
                    realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category: \(error)")
            }
            //tableView.reloadData()
        }
    }
    
    fileprivate func animateIn(cell: UITableViewCell, withDelay delay: TimeInterval) {
        let initialScale: CGFloat = 1.2
        let duration: TimeInterval = 0.6
        
        cell.alpha = 0.0
        cell.layer.transform = CATransform3DMakeScale(initialScale, initialScale, 1)
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseOut, animations: {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
    }
}
