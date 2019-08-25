//
//  File.swift
//  todo-app
//
//  Created by Panupong Kukutapan on 3/8/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var detail: String? = nil
    @objc dynamic var completed: Bool = false
    @objc dynamic var createdDate: Date = Date()
    @objc dynamic var completedDate: Date? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
