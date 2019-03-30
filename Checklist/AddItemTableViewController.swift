//
//  AddItemTableViewController.swift
//  Checklist
//
//  Created by Shalise Ayromloo on 3/28/19.
//  Copyright © 2019 Shalise Ayromloo. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController)
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem)
    func addItemViewController(_ controller: AddItemTableViewController, didFinishEditing item: ChecklistItem)
    
    
} // closes protocol


class AddItemTableViewController: UITableViewController {
    
    weak var delegate: AddItemViewControllerDelegate?
    weak var todoList: TodoList?
    weak var itemToEdit: ChecklistItem?
    
    
    
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            addBarButton.isEnabled = true
        } //closes if-let
        
        navigationItem.largeTitleDisplayMode = .never
        
    } //closes viewDidLoad()
    
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    } //closes viewWillAppear()
    

  
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.addItemViewControllerDidCancel(self)
    } //closes IBACtion cancel
    
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        if let item = itemToEdit, let text = textField.text {
            item.text = text
            delegate?.addItemViewController(self, didFinishEditing: item)
        } else {
            if let item = todoList?.newTodo() {
                if let textFieldText = textField.text {
                    item.text = textFieldText
                } //closes if-let
                item.checked = false
                delegate?.addItemViewController(self, didFinishAdding: item)
            } //closes if-let
        } //closes if-let-else
        
    } //closes IBAction done
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
} //closes class

extension AddItemTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false        
    } //closes function
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = textField.text, let stringRange = Range(range, in: oldText) else {return false}
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            addBarButton.isEnabled = false
        } else {
            addBarButton.isEnabled = true
        } //closes if-else
        return true
        
    } //closes function
    
} //closes extension
