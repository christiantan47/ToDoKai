//
//  ViewController.swift
//  ToDoKai
//
//  Created by Tan Christian on 17/11/18.
//  Copyright © 2018 Tan Christian. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray: Array<Items> = [Items]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
        loadItems()
        
    }

    //MARK: TableView Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
         return cell
        // ^^ line code di atas sama gunanya seperti line if code di bawah vv
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
//
    }
    
    //MARK: TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //Satu baris line code di atas sama dengan rumus if dibawah hasilnya
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
//
      saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoKai Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title:"Add Item", style: .default) { (action) in
            //what will happen when user click add button on UIAlert
            
            let newItem = Items()
             newItem.title = textField.text!
            self.itemArray.append(newItem)
           
            
            self.saveItems()
            
            
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
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do {
            let data:Data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch  {
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Items].self, from: data)}
            catch{
                print(error)
            }
        }
        
        
    }
}

