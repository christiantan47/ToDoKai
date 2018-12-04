//
//  ViewController.swift
//  ToDoKai
//
//  Created by Tan Christian on 17/11/18.
//  Copyright © 2018 Tan Christian. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

    var toDoItems: Results<Items>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            print("a")
            loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
    }

    //MARK: TableView Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done == true ? .checkmark : .none
        } else {
             cell.textLabel?.text = "no item added"
        }
       
        
         return cell
 
    }
    
    //MARK: TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let items = toDoItems?[indexPath.row] {
            do {
            try realm.write {
                items.done = !items.done
                }} catch {
                    print ("error saving done status \(error)")
            }
        }
        
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoKai Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title:"Add Item", style: .default) { (action) in
            //what will happen when user click add button on UIAlert
            
            if let currentCategory = self.selectedCategory {
                do{
                    try self.realm.write {
                    let newItem = Items()
                    newItem.title = textField.text!
                        newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }
                }catch{
                    print("error saving new items \(error)")
                }
            }
           
           self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            print(alertTextField.text)
            print("now")
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK : Model Manipulation Method
    
    func loadItems(){
        toDoItems = selectedCategory?.items.sorted(byKeyPath : "title", ascending: true)
        tableView.reloadData()
    }
    
   
}

// MARK : Search Bar Method
extension ToDoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
//        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
    

}
