//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Mary Arnold on 7/16/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    //set new Realm
    let realm = try! Realm()
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destimationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destimationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manipulation Methods - saveData/loadData
    func save(catergory: Category) {
        //items to have to Persistent Local Data Storage
        do {
            try realm.write() {
                realm.add(catergory)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        //reloads List to show the added category
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        
    }
//    //Reading DB so don't have to call context & saveItems - with internal & external paramater with default values
//    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
//        //must specify the data output type
//
//        //fetches content from DB
//        do {
//            categories = try context.fetch(request)
//        } catch {
//            print("Error loading categories \(error)")
//        }
//        tableView.reloadData()
//    }
    
    //MARK: - Add New Categories - using Category Intity
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what will happen once user clicked addCategoryButton on our alert
            
            //add new category to List
            let newCategory = Category()
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            
            self.save(catergory: newCategory)
        }
        
        //activate alert popup
        alert.addAction(action)
        
        //add text field to alert
        alert.addTextField { (field) in
            field.placeholder = "Create a new category"
            
            //extending scope of alertTextField to addButtonPressed
            textField = field
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Table Delegate Methods - Leave for now
    
}

