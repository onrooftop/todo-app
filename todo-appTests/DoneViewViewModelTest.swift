//
//  DoneViewViewModel.swift
//  todo-appTests
//
//  Created by Panupong Kukutapan on 9/9/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import XCTest
@testable import todo_app

import RealmSwift

class DoneViewViewModelTest: XCTestCase {

    var database: Database!
    var viewModel: DoneViewViewModelType!
    
    override func setUp() {
        var config = Realm.Configuration()
        config.inMemoryIdentifier = self.name + "_test"
        database = Database(config: config)
        
        let task1 = Task()
        task1.title = "title1"
        task1.completed = true
        task1.completedDate = Date().addingTimeInterval(-TimeInterval(10000))
        let task2 = Task()
        task2.title = "title2"
        task2.completed = true
        task2.completedDate = Date().addingTimeInterval(-TimeInterval(25000))
        let task3 = Task()
        task3.title = "title3"
        task3.completedDate = Date().addingTimeInterval(-TimeInterval(30000))
        
        database.createOrUpdate(task: task1)
        
        database.createOrUpdate(task: task2)
        
        database.createOrUpdate(task: task3)
        
        viewModel = DoneViewViewModel(database: database)
    }

    func test_todo_task() {
        
        let tasks = viewModel.output.tasks
        let taskTitleCheck = tasks.first!.title
        viewModel.input.todoTask(task: tasks.first!)
        
        let tasksCheck = viewModel.output.tasks
        
        XCTAssertEqual(tasksCheck.count, 1)
        XCTAssertEqual(tasksCheck.filter { $0.title == taskTitleCheck}.count, 0)
    }
    
    func test_delete_task() {
        var tasks = viewModel.output.tasks
        
        XCTAssertEqual(tasks.count, 2)
        
        viewModel.input.deleteTask(task: tasks.first!)
        
        tasks = viewModel.output.tasks
        
        XCTAssertEqual(tasks.count, 1)
    }
    
    func test_tasks() {
        let tasks = viewModel.output.tasks
        
        XCTAssertEqual(tasks.count, 2)
        XCTAssertEqual(tasks.first!.title, "title2")
    }

}
