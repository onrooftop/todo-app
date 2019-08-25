//
//  Database.swift
//  todo-app
//
//  Created by Panupong Kukutapan on 17/8/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation
import RealmSwift

class Database {
    static let shared = Database()
    private(set) var realm: Realm!
    init() { realm = try! Realm() }
    
    func createOrUpdate(task: Task) {
        
        if(task.id == 0) {
            task.id = (getAllTasks().max(ofProperty: "id") ?? 0) + 1
        }
        
        try! realm.write {
            realm.add(task, update: Realm.UpdatePolicy.modified)
        }
    }
    
    func getAllTasks() -> Results<Task> {
        return realm.objects(Task.self)
    }
    
    func deleteTask(task: Task) {
        try! realm.write {
            realm.delete(task)
        }
    }
}
