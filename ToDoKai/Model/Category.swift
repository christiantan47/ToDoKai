//
//  Category.swift
//  ToDoKai
//
//  Created by Tan Christian on 01/12/18.
//  Copyright © 2018 Tan Christian. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Items>()
    
    
}
