//
//  Category.swift
//  Todoey
//
//  Created by ALEKSEY SUSLOV on 26.08.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
