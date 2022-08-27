//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by ALEKSEY SUSLOV on 25.08.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCaterories()
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navogation Controller does not exist.")
        }
        
        navBar.standardAppearance.backgroundColor = UIColor(hexString: "1D9BF6")
        navBar.scrollEdgeAppearance?.backgroundColor = UIColor(hexString: "1D9BF6")
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        if let category = categories?[indexPath.row], let categoryColor = UIColor(hexString: category.color) {
            content.text = category.name
            content.textProperties.color = ContrastColorOf(categoryColor, returnFlat: true)
            cell.backgroundColor = categoryColor
        } else {
            content.text = "No Categories Added Yet"
        }
        
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
                newCategory.color = UIColor.randomFlat().hexValue()
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
    
    
    // MARK: - Deleta data from swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write({
                    self.realm.delete(categoryForDeletion)
                })
            } catch {
                print("Error saving Done status \(error)")
            }
        }
        
    }
    
    
}


