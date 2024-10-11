//
//  AddToDoViewController.swift
//  Innova7.Odev-SQLite-ToDoListe
//
//  Created by Merve Çalışkan on 11.10.2024.
//

import UIKit

class AddToDoViewController: UIViewController {
    @IBOutlet weak var tf: UITextField!
    var viewModel = ToDoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func addToDoButton(_ sender: UIButton) {
        if let todoName = tf.text, !todoName.isEmpty {
            viewModel.addTodo(name: todoName)
            let alert = UIAlertController(title: "Başarılı", message: "Görev eklendi: \(todoName)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func mainButton(_ sender: UIButton) {
//        performSegue(withIdentifier: "mainShow", sender: (Any).self)
    }
    
}
