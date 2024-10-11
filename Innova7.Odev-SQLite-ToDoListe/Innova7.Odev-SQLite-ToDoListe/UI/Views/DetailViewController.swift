//
//  DetailViewController.swift
//  Innova7.Odev-SQLite-ToDoListe
//
//  Created by Merve Çalışkan on 11.10.2024.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var toDo: ToDo?
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = toDo?.name
        
    }

}
