//
//  Item.swift
//  Todoey
//
//  Created by Mary Arnold on 7/17/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    //Creates inverse relationship that linkes each item back to the Category
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
