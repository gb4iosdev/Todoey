//
//  Item.swift
//  Todoey
//
//  Created by Gavin Butler on 11-04-2018.
//  Copyright © 2018 Gavin Butler. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
