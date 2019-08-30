//
//  ViewController.swift
//  ToDoey
//
//  Created by L Sekhon on 8/25/19.
//  Copyright © 2019 Lavleen Sekhon. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy 4 Burgers"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Go to India"
        itemArray.append(newItem3)
        
        // Do any additional setup after loading the view.
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
    }
    //Mark - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //this allows you to reuse the cells
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        let item = itemArray[indexPath.row]
        
        //allows you to fit every labels in each cell
        cell.textLabel!.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }

    //Mark - TableView Delegate Methods
    
    //when the user selects something
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       print(itemArray[indexPath.row])

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.reloadData()
        
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
     var textField = UITextField()
     
      let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add button on our UIAlert
            print("Success")
         
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
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

