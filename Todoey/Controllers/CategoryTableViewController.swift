//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by ALEKSEY SUSLOV on 25.08.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCaterories()
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    // MARK: - Data manipulation methods
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category",
                                      message: "",
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            if let text = textField.text, text != "" {
                
                let newCategory = Category()
                newCategory.name = text
                self.save(category: newCategory)
            }
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    private func save(category: Category) {
        do {
            try realm.write({
                realm.add(category)
            })
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    private func loadCaterories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
}
