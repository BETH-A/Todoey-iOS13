//
//  Category.swift
//  Todoey
//
//  Created by Mary Arnold on 7/17/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

//Realm Object - dynamic var to monitor for changes in realtime
class Category: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var categoryColor : String = UIColor.randomFlat().hexValue()

    
    //Creats relationship to Item
    let items = List<Item>()
}
