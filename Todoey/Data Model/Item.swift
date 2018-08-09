//
//  Item.swift
//  Todoey
//
//  Created by Cemal Arda KIZILKAYA on 8.08.2018.
//  Copyright © 2018 Cemal Arda KIZILKAYA. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var creationDate : Date = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
