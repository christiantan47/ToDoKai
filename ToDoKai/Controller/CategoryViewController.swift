//
//  CategoryViewController.swift
//  ToDoKai
//
//  Created by Tan Christian on 28/11/18.
//  Copyright © 2018 Tan Christian. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray : Array<Category> = [Category]()
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

      loadCategories()
    }


    //MARK : Tableview DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    //MARK : Tableview Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            let selectedRow = categoryArray[indexPath.row]
            destinationVC.selectedCategory = selectedRow
            destinationVC.title = selectedRow.name!
        }
    }
    //MARK : Add New Category

    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            self.saveCategories()
            
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            print(textField.text)
        }
        
         present(alert, animated: true, completion: nil)
    }
    
    //MARK : Data Manipulation

    func saveCategories(){
        
        do {
            try context.save()
        } catch  {
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(with request:NSFetchRequest<Category> = Category.fetchRequest()){
        
        do {
            categoryArray = try context.fetch(request)
        } catch  {
            print("error request \(error)")
        }
        
        tableView.reloadData()
    }
}