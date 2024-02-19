//
//  TableViewController.swift
//  Lab_6
//
//  Created by user237779 on 2/19/24.
//

import UIKit



struct TodoItem: Codable {
    var title: String
}


class TableViewController: UITableViewController {

    var taskLists = [TodoItem]()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           loadTodoItems()
       }
       

       
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return taskLists.count
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "DoCell", for: indexPath)
           let todoItem = taskLists[indexPath.row]
           cell.textLabel?.text = todoItem.title
           return cell
       }
       
    

   
    @IBOutlet weak var add: UIButton!
    
    
    @IBAction func add(_ sender: UIButton) {
        AddAlert ()
    }
    
    

       private func AddAlert() {
           let alertController = UIAlertController(title: "Enter Task", message: nil, preferredStyle: .alert)
           
           alertController.addTextField { textField in
               textField.placeholder = "Task Details"
           }
           
           let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
               if let textField = alertController.textFields?.first, let text = textField.text, !text.isEmpty {
                   let newTodoItem = TodoItem(title: text)
                   self?.taskLists.append(newTodoItem)
                   self?.saveTodoItems()
                   self?.tableView.reloadData()
               }
           }
           
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           
           alertController.addAction(addAction)
           alertController.addAction(cancelAction)
           
           present(alertController, animated: true, completion: nil)
       }
 

    private func saveTodoItems() {
           let data = try? JSONEncoder().encode(taskLists)
           UserDefaults.standard.set(data, forKey: "todoItems")
       }
        
       
    
       private func loadTodoItems() {
           if let data = UserDefaults.standard.data(forKey: "todoItems"),
              let savedTodoItems = try? JSONDecoder().decode([TodoItem].self, from: data) {
               taskLists = savedTodoItems
           }
       }
       

       override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               taskLists.remove(at: indexPath.row)
               saveTodoItems()
               tableView.deleteRows(at: [indexPath], with: .fade)
           }
       }
}
