//
//  TodoViewModelTest.swift
//  todo-appTests
//
//  Created by Panupong Kukutapan on 11/8/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import XCTest
import RealmSwift
@testable import todo_app
class TodoViewModelTest: XCTestCase {

    var vm: TodoViewModelType!
    
    var database: Database!
    let tasks: [Task] = [
        Task(),
        Task()
    ]
    
    override func setUp() {
        
        var config = Realm.Configuration()
        config.inMemoryIdentifier = self.name + "_test"
        database = Database(config: config)
        try! database.realm.write {
            database.realm.deleteAll()
        }
        // Put setup code here. This method is called before the invocation of each test method in the
        tasks[0].title = "Task1"
        tasks[0].createdDate = Date().addingTimeInterval(-TimeInterval(exactly: 60 * 5)!)
        tasks[1].title = "Task2"
        tasks[1].createdDate = Date().addingTimeInterval(-TimeInterval(exactly: 60 * 60 * 2)!)
        vm = TodoViewModel(database: database)
        
        tasks.forEach { (task) in
            self.vm.input.createTask(title: task.title, detail: task.detail)
        }
    }

    override func tearDown() {
        try! database.realm.write {
            database.realm.deleteAll()
        }
    }
    
    func testCreateTask() {
    
        
        vm.output.reloadData = { [unowned self] in
            let task = self.vm.output.todoTasks.last!
            XCTAssertEqual(task.title, "title")
            XCTAssertEqual(task.detail!, "detail")
            XCTAssertFalse(task.completed)
            XCTAssertNil(task.completedDate)
            XCTAssertTrue(Date().compare(task.createdDate) == .orderedDescending)
        }
        
        
        vm.input.createTask(title: "title", detail: "detail")
    }
    
    func testDeleteTask() {
        
        let index = 0
        let deletedId = vm.output.todoTasks[index].id
        let numberOfTasks = vm.output.todoTasks.count

        vm.output.reloadData = { [unowned self] in
            
            XCTAssertEqual(self.vm.output.todoTasks.count, numberOfTasks - 1)
            XCTAssertFalse((self.vm.output.todoTasks.contains(where: { (task) -> Bool in
                return task.id == deletedId
            })))
            
        }
        
        vm.input.deleteTask(at: index)
        
    }
    
    func testDoneTask() {
        let index = 0
        XCTAssertFalse(vm.output.todoTasks[index].completed)
        let numberOfTasks = vm.output.todoTasks.count
        
        vm.output.reloadData = { [unowned self] in
            XCTAssertEqual(self.vm.output.todoTasks.filter{$0.completed == false}.count, numberOfTasks - 1)
            XCTAssertFalse(self.vm.output.todoTasks.contains{$0.completed == true})
        }
        
        
        vm.input.doneTask(at: index)
    }
    
    func testIsSearching() {
        
        vm.input.search(with: "A")
        
        XCTAssertTrue(vm.output.isSearching)
    }
    
    func testIsNotSearching() {
        vm.input.search(with: "")
        XCTAssertFalse(vm.output.isSearching)
    }
    
    func testSearch() {
        
        let taskA = Task()
        taskA.title = "A"
        let taskAB = Task()
        taskAB.title = "AB"
        let taskABC = Task()
        taskABC.title = "ABC"
        let taskABCD = Task()
        taskABCD.title = "ABCD"
        
        let testTasks = [taskA, taskAB, taskABC, taskABCD]
        
        testTasks.forEach { (task) in
            vm.input.createTask(title: task.title, detail: task.detail)
        }
        
        let query = "C"
        
        vm.output.reloadData = { [unowned self] in
            XCTAssertEqual(self.vm.output.todoTasks.count, 2)
        }
        
        vm.input.search(with: query)
    }
    
    func testSearchWithEmpty() {
        
        try! database.realm.write {
            database.realm.deleteAll()
        }
        
        let taskA = Task()
        taskA.title = "A"
        let taskAB = Task()
        taskAB.title = "AB"
        let taskABC = Task()
        taskABC.title = "ABC"
        let taskABCD = Task()
        taskABCD.title = "ABCD"
        
        let testTasks = [taskA, taskAB, taskABC, taskABCD]
        
        testTasks.forEach { (task) in
            vm.input.createTask(title: task.title, detail: task.detail)
        }
        
        let query = ""
        
        vm.output.reloadData = { [unowned self] in
            XCTAssertEqual(self.vm.output.todoTasks.count, 4)
        }
        
        vm.input.search(with: query)
    }
    
    
}
