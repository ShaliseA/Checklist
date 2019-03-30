//
//  ChecklistItems.swift
//  Checklist
//
//  Created by Shalise Ayromloo on 3/21/19.
//  Copyright © 2019 Shalise Ayromloo. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    
   var text = ""
   var checked = false
    
    func toggleChecked() {
        checked = !checked 
    }
    
} //closes class
