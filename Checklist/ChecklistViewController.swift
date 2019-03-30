//
//  ViewController.swift
//  Checklist
//
//  Created by Shalise Ayromloo on 3/21/19.
//  Copyright © 2019 Shalise Ayromloo. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var todoList: TodoList
    
    required init?(coder aDecoder: NSCoder){
        
        todoList = TodoList()
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.todos.count
    } //closes  tableView

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        let item = todoList.todos[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = todoList.todos[indexPath.row]
            configureCheckmark(for: cell, with: item)
            tableView.deselectRow(at: indexPath, animated: true)
        } //closes if-let
    } //closes function
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { //by just writing the function without any codes, when we swipe left a delte button appears but if we click on it, nothing will happen
        
        todoList.todos.remove(at: indexPath.row)
        //let indexPaths = [indexPath]
        //tableView.deleteRows(at: indexPaths, with: .automatic)
        
        tableView.reloadData()
    } //closes function

    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        if let label = cell.viewWithTag(1000) as? UILabel {
            
            label.text = item.text
            
        } //closes if let
    } //closes function




    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        guard let checkmark = cell.viewWithTag(1001) as? UILabel else {return}
        if item.checked {
          checkmark.text = "√"
        } else {
            checkmark.text = ""
        } //closes if-else
        
        item.toggleChecked()
        
    } //closes function
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let addItemViewController = segue.destination as? AddItemTableViewController {
                addItemViewController.delegate = self
                addItemViewController.todoList = todoList
            } //closes if-let
            
        } else if segue.identifier == "EditItemSegue" {
            if let addItemViewController = segue.destination as? AddItemTableViewController {
                if let cell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: cell) {
                    let item = todoList.todos[indexPath.row]
                    addItemViewController.itemToEdit = item
                    addItemViewController.delegate = self
                    
                } //closes if-let
                
            } //closes if-let
            
        } //closes if-else if
    } //closes function
    
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
       
        let newRowIndex = todoList.todos.count
        _ = todoList.newTodo() //I'm not interested in working with the object returned from this method
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    
} //closes class


extension ChecklistViewController: AddItemViewControllerDelegate {
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController) {
        navigationController?.popViewController(animated: true)
    } //closes function
    
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = todoList.todos.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    } //closes function
    
    
    func addItemViewController(_ controller: AddItemTableViewController, didFinishEditing item: ChecklistItem) {
        if let index = todoList.todos.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            } //closes if-let
        } //closes if-let
        navigationController?.popViewController(animated: true)
        
    } //closes function
    
    
    
    
} //closes extension
