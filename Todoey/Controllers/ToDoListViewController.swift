//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //set Search Bar Delegate from Main.storyboard
        
        //Retrieve array from Persistant Local Data Storage
        loadItems()
        
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //setting accesspryType using Ternary operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods for cell clicked
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Adding/Removing Checkmarks on cell clicked
        //set property of selected item by setting it to opposite of what it was
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //remove item when clicked
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        
        self.saveItems()
        
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
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
            self.saveItems()
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
    
    
    
    //MARK: - Model Manupulation Methods
    
    func saveItems() {
        //items to have to Persistent Local Data Storage
        do{
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        //reloads List to show the added item
        self.tableView.reloadData()
    }
    
    //Reading DB so don't have to call context & saveItems - with internal & external paramater with default values
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        //must specify the data output type

        //fetches content from DB
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching context \(error)")
        }
    }
    
    
}
//MARK: - Search Bar Methods

extension ToDoListViewController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
    }
    
    
}

