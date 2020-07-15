//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let itemArray = ["Code", "Finish Portfolio", "Find Job"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        //print (itemArray[indexPath.row])
        
        //highlights selected cell for just a sec & then returns to background color
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
}





