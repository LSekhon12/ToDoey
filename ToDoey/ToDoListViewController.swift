//
//  ViewController.swift
//  ToDoey
//
//  Created by L Sekhon on 8/25/19.
//  Copyright © 2019 Lavleen Sekhon. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["Bring Mike", "Buy Eggs", "Get 4 Burgers"]
    
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
}

