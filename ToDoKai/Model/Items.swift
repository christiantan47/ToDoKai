//
//  Items.swift
//  ToDoKai
//
//  Created by Tan Christian on 01/12/18.
//  Copyright © 2018 Tan Christian. All rights reserved.
//

import Foundation
import RealmSwift

class Items : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
