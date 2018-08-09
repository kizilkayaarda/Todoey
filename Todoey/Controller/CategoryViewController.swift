//
//  TableViewController.swift
//  Todoey
//
//  Created by Cemal Arda KIZILKAYA on 7.08.2018.
//  Copyright © 2018 Cemal Arda KIZILKAYA. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
    }
    
    //MARK - DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories"
        
        cell.backgroundColor = UIColor(hexString: categories![indexPath.row].color) ?? UIColor.clear
        
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        
        return cell
    }
    
    
    //MARK - TabelView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK - Data Manipulation Methods
    func save( category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Saving error \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData() {
        
        categories = realm.objects(Category.self)

        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let itemToBeDeleted = self.categories?[indexPath.row] {
        
            do {
                try self.realm.write {
                    self.realm.delete(itemToBeDeleted)
                }
            } catch {
                print("Deleting cell error , \(error)")
            }
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            
            newCategory.name = alertTextField.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            
            self.save( category: newCategory)
        }
        
        alert.addAction(action)
        
        alert.addTextField { (textField) in
            
            textField.placeholder = "Category name"
            alertTextField = textField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}

