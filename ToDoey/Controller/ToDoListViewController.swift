//
//  ViewController.swift
//  ToDoey
//
//  Created by L Sekhon on 8/25/19.
//  Copyright © 2019 Lavleen Sekhon. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadItems()
        // Do any additional setup after loading the view.
        //if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            //itemArray = items
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

        saveData()
        
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
            self.saveData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    
    }
    func saveData(){
    let encoder = PropertyListEncoder()
    do{
    let data = try encoder.encode(self.itemArray)
    try data.write(to: self.dataFilePath!)
    }catch{
    print("Error encoding item array, \(error)")
    }
    self.tableView.reloadData()
    }
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item array, \(error)")
            }
        }
    }
}


