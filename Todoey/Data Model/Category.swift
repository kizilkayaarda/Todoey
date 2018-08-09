//
//  Category.swift
//  Todoey
//
//  Created by Cemal Arda KIZILKAYA on 8.08.2018.
//  Copyright © 2018 Cemal Arda KIZILKAYA. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}

