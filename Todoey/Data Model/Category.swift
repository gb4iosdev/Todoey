//
//  Category.swift
//  Todoey
//
//  Created by Gavin Butler on 11-04-2018.
//  Copyright © 2018 Gavin Butler. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var bgColour: String = ""
    let items = List<Item>()
}
