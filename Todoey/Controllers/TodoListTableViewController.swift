//
//  TodoListTableViewController.swift
//  Todoey
//
//  Created by ALEKSEY SUSLOV on 22.08.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    var itemArray: [TodoItem] = [
        TodoItem(title: "Find Mike", isDone: false),
        TodoItem(title: "Buy Eggos", isDone: false),
        TodoItem(title: "Destroy Demogorgon", isDone: false),
        TodoItem(title: "qwe", isDone: false),
        TodoItem(title: "asdfasdf", isDone: false),
        TodoItem(title: "q", isDone: false),
        TodoItem(title: "asdgfasgd", isDone: false),
        TodoItem(title: "sdfadsg", isDone: false),
        TodoItem(title: "asdgfasdg", isDone: false),
        TodoItem(title: "f", isDone: false),
        TodoItem(title: "q", isDone: false),
        TodoItem(title: "qw", isDone: false),
        TodoItem(title: "1", isDone: false),
        TodoItem(title: "2", isDone: false),
        TodoItem(title: "3", isDone: false),
        TodoItem(title: "4", isDone: false),
        TodoItem(title: "5", isDone: false),
        TodoItem(title: "6", isDone: false),
        TodoItem(title: "7", isDone: false),
        TodoItem(title: "8", isDone: false),
        TodoItem(title: "9", isDone: false),
        TodoItem(title: "0", isDone: false),
        TodoItem(title: "z", isDone: false),
        TodoItem(title: "x", isDone: false),
        TodoItem(title: "c", isDone: false),
        TodoItem(title: "v", isDone: false),
        TodoItem(title: "b", isDone: false),
        TodoItem(title: "n", isDone: false),
        TodoItem(title: "m", isDone: false),
        TodoItem(title: "asd", isDone: false)
    ]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")

        var content = cell.defaultContentConfiguration()
        content.text = itemArray[indexPath.row].title
        cell.contentConfiguration = content
        
        cell.accessoryType = itemArray[indexPath.row].isDone ? .checkmark : .none

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].isDone.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item",
                                      message: "",
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item",
                                   style: .default) { action in
            //what will happen once the user clicks the Add Item button on our UIAlert
            if let text = textField.text, text != "" {
//                self.itemArray.append(text)
                
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}
