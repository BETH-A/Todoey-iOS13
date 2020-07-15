//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Code", "Finish Portfolio", "Find Job"]
    
    //sets up Persistent Local Data Storage
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
        
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods for cell clicked
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Adding/Removing Checkmarks on cell clicked
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            //remove check mark when clicked 2nd time
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            //add check mark to cells when clicked
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //highlights selected cell for just a sec & then returns to background color
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        //what will happen once user clicked addItemButton on our alert
            
            //add new item to List
            self.itemArray.append(textField.text!)
            
            //items to have to Persistent Local Data Storage
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            
            //reloads List to show the added item
            self.tableView.reloadData()
        }
        
        //add text field to alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            
            //extending scope of alertTextField to addButtonPressed
            textField = alertTextField
        }
        
        //activate alert popup
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}





