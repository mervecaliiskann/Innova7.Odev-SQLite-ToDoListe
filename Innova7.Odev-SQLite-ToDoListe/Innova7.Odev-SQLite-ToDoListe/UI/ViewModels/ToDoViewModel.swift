//
//  ToDoViewModel.swift
//  Innova7.Odev-SQLite-ToDoListe
//
//  Created by Merve Çalışkan on 11.10.2024.
//

import Foundation
import SQLite3


final class ToDoViewModel {
    
    var todos: [ToDo] = []
    var database: OpaquePointer?
    
    init() {
        let dbPath = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("todos.sqlite")
        if sqlite3_open(dbPath?.path, &database) != SQLITE_OK {
            print("Veritabanı açılamadı")
            return
        
        }
        let createTableQuery = "CREATE TABLE IF NOT EXISTS toDos (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)"
        if sqlite3_exec(database, createTableQuery, nil, nil, nil) != SQLITE_OK {
            print("Tablo oluşturulamadı")
        }
    }
    func fetchTodos() {
        todos.removeAll()
        let query = "SELECT * FROM toDos"
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(database, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let id = sqlite3_column_int(stmt, 0)
                let name = String(cString: sqlite3_column_text(stmt, 1))
                todos.append(ToDo(id: Int(id), name: name))
            }
        }
        sqlite3_finalize(stmt)
    }
    
    func addTodo(name: String) {
        let insertQuery = "INSERT INTO toDos (name) VALUES (?)"
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(database, insertQuery, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, (name as NSString).utf8String, -1, nil)
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Görev eklendi")
            } else {
                print("Görev eklenemedi")
            }
        }
        sqlite3_finalize(stmt)
        fetchTodos()
    }
    
    func deleteTodo(id: Int) {
        let deleteQuery = "DELETE FROM toDos WHERE id = ?"
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(database, deleteQuery, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_int(stmt, 1, Int32(id))
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Görev silindi")
            } else {
                print("Görev silinemedi")
            }
        }
        sqlite3_finalize(stmt)
        fetchTodos()
    }
    
}
