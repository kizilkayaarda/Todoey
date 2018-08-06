//
//  ViewController.swift
//  Todoey
//
//  Created by Cemal Arda KIZILKAYA on 6.08.2018.
//  Copyright © 2018 Cemal Arda KIZILKAYA. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    
    var itemArray = [Item]()

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.name = "Groceries"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.name = "Pets"
        itemArray.append(newItem1)
        
        if let items = defaults.array(forKey: "TodoArray") as? [Item] {
            itemArray = items
        }
        
    }
    
    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }

    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todo", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let item = Item()
            
            item.name = textField.text!
            
            self.itemArray.append(item)
            
            self.defaults.set(self.itemArray, forKey: "TodoArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
            
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
            

        }
}


