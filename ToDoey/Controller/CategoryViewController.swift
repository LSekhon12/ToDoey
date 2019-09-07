//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by L Sekhon on 9/1/19.
//  Copyright © 2019 Lavleen Sekhon. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoCategoryCell")
        let item = categoryArray[indexPath.row]
        cell.textLabel!.text = item.name
        
        return cell
    }
        //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    func saveCategories(){
        do{
            try context.save()
        }
        catch{
            print("Error saving categories: \(error)")
        }
        self.tableView.reloadData()
    }
    func loadCategories(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            categoryArray = try context.fetch(request)
        }
        catch{
            print("Error fetching categories \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Add new categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Add Categories", style: .default) { (action) in
        
        let newCategory = Category(context: self.context)
        newCategory.name = textField.text!
        self.categoryArray.append(newCategory)
        self.saveCategories()
    }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
    alert.addAction(alertAction)
        
    present(alert, animated: true, completion: nil)
   }

    
}
