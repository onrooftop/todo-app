//
//  DatabaseTest.swift
//  todo-appTests
//
//  Created by Panupong Kukutapan on 17/8/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import XCTest
import RealmSwift

@testable import todo_app

class DatabaseTest: XCTestCase {

    var database: Database!
    override func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the
        
        
        var config = Realm.Configuration()
        config.inMemoryIdentifier = self.name + "_test"
        database = Database(config: config)
        
        
        try! database.realm.write {
            database.realm.deleteAll()
        }
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetAllTasksWithNone() {
        let tasks = database.getAllTasks()
        XCTAssertEqual(tasks.count, 0)
    }
    
    func testCreateTask() {
        let task = Task()
        task.title = "Task"
        database.createOrUpdate(task: task)
        
        let tasks = database.getAllTasks()
        XCTAssertEqual(task, tasks[0])
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks[0].id, 1)
    }
    
    func testUpdateTask() {
        let task = Task()
        task.title = "A"
        
        database.createOrUpdate(task: task)
        var tasks = database.getAllTasks()
        XCTAssertEqual("A", tasks[0].title)
        XCTAssertEqual(1, tasks.count)
        
        let taskUpdate = Task()
        taskUpdate.id = tasks[0].id
        taskUpdate.title = "updated"
        database.createOrUpdate(task: taskUpdate)
        tasks = database.getAllTasks()
        XCTAssertEqual(1, tasks.count)
        XCTAssertEqual("updated", tasks[0].title)
    }
    
    func testIdincreament() {
        let task1 = Task()
        let task2 = Task()
        let task3 = Task()
        
        database.createOrUpdate(task: task1)
        database.createOrUpdate(task: task2)
        database.createOrUpdate(task: task3)
        
        let tasks = database.getAllTasks()
        
        XCTAssertEqual(3, tasks.last!.id)
        
        let task3Update = Task()
        task3Update.id = tasks.last!.id
        
        database.createOrUpdate(task: task3Update)
        
        let tasksAfterUpdate = database.getAllTasks()
        XCTAssertEqual(3, tasksAfterUpdate.last!.id)
        
    }
    
    func testDeletion() {
        let task1 = Task()
        let task2 = Task()
        task2.title = "2"
        
        database.createOrUpdate(task: task1)
        database.createOrUpdate(task: task2)
        
        database.deleteTask(task: task1)
        
        let tasks = database.getAllTasks()
        XCTAssertEqual(1, tasks.count)
        XCTAssertEqual("2", tasks[0].title)
    }


}
