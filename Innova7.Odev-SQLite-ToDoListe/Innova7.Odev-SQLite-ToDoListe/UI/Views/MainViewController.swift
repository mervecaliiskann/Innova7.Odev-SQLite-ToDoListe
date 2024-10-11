//
//  MainViewController.swift
//  Innova7.Odev-SQLite-ToDoListe
//
//  Created by Merve Çalışkan on 11.10.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    
    var viewModel = ToDoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad çağrıldı")
        viewModel.fetchTodos()
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewWillAppear çağrıldı")
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.fetchTodos()
        tableView.reloadData()
    }
    
    @IBAction func addToButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "addToShow", sender: self)
    }
    

}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        let todo = viewModel.todos[indexPath.row]
        
        cell.textLabel?.text = todo.name
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             let todoToDelete = viewModel.todos[indexPath.row]
             
             viewModel.deleteTodo(id: todoToDelete.id)
             
             tableView.deleteRows(at: [indexPath], with: .automatic)
         }
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = viewModel.todos[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        detailVC.toDo = todo
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
