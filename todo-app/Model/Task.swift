//
//  File.swift
//  todo-app
//
//  Created by Panupong Kukutapan on 3/8/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation

class Task {
    var title: String!
    var detail: String?
    var completed: Bool = false
    var createdDate: Date!
    var completedDate: Date? = nil
    
    init(title: String!, detail: String?, createdDate: Date!, completed: Bool) {
        self.title = title
        self.detail = detail
        self.createdDate = createdDate
        self.completed = completed
    }
}
