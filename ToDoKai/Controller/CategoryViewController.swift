//
//  CategoryViewController.swift
//  ToDoKai
//
//  Created by Tan Christian on 28/11/18.
//  Copyright © 2018 Tan Christian. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    var categoryArray : Results<Category>?
    
   let realm = try! Realm()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      loadCategories()
    }


    //MARK : Tableview DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Category Added"
        
        return cell
    }
    
    //MARK : Tableview Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
            
        }
    }
    //MARK : Add New Category

    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
            
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

    func save(category : Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch  {
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(){
        
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
}
