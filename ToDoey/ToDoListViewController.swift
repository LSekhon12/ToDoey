//
//  ViewController.swift
//  ToDoey
//
//  Created by L Sekhon on 8/25/19.
//  Copyright © 2019 Lavleen Sekhon. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Bring Mike", "Buy Eggs", "Get 4 Burgers"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //Mark - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //this allows you to reuse the cells
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        //allows you to fit every labels in each cell
        cell.textLabel!.text = itemArray[indexPath.row]
        
        return cell
    }

    //Mark - TableView Delegate Methods
    
    //when the user selects something
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       print(itemArray[indexPath.row])

        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
     var textField = UITextField()
     
      let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add button on our UIAlert
            print("Success")
          self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

