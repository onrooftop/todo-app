//
//  TodoViewModelTest.swift
//  todo-appTests
//
//  Created by Panupong Kukutapan on 11/8/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import XCTest
@testable import todo_app
class TodoViewModelTest: XCTestCase {

    var vm: TodoViewModelType!
    let tasks: [Task] = [
        Task(title: "Task1", detail: nil, createdDate: Date().addingTimeInterval(-TimeInterval(exactly: 60 * 5)!), completed: false),
        Task(title: "Task2", detail: nil, createdDate: Date().addingTimeInterval(-TimeInterval(exactly: 60 * 60 * 2)!), completed: false)
    ]
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vm = TodoViewModel(tasks: tasks)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
        let deletedTask = vm.output.todoTasks[index]
        let numberOfTasks = vm.output.todoTasks.count

        vm.output.reloadData = { [unowned self] in
            
            XCTAssertEqual(self.vm.output.todoTasks.count, numberOfTasks - 1)
            XCTAssertFalse((self.vm.output.todoTasks.contains(where: { (task) -> Bool in
                return task.title == deletedTask.title && task.detail == deletedTask.detail
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
        let testTasks = [
            Task(title: "A", detail: nil, createdDate: Date().addingTimeInterval(-TimeInterval(exactly: 60 * 5)!), completed: false),
            Task(title: "AB", detail: nil, createdDate: Date().addingTimeInterval(-TimeInterval(exactly: 60 * 5)!), completed: false),
            Task(title: "ABC", detail: nil, createdDate: Date().addingTimeInterval(-TimeInterval(exactly: 60 * 5)!), completed: false),
            Task(title: "ABCD", detail: nil, createdDate: Date().addingTimeInterval(-TimeInterval(exactly: 60 * 5)!), completed: false),
        ]
        
        vm = TodoViewModel(tasks: testTasks)
        
        let query = "C"
        
        vm.output.reloadData = { [unowned self] in
            XCTAssertEqual(self.vm.output.todoTasks.count, 2)
        }
        
        vm.input.search(with: query)
    }
    
    func testSearchWithEmpty() {
        let testTasks = [
            Task(title: "A", detail: nil, createdDate: Date().addingTimeInterval(-TimeInterval(exactly: 60 * 5)!), completed: false),
            Task(title: "AB", detail: nil, createdDate: Date().addingTimeInterval(-TimeInterval(exactly: 60 * 5)!), completed: false),
            Task(title: "ABC", detail: nil, createdDate: Date().addingTimeInterval(-TimeInterval(exactly: 60 * 5)!), completed: false),
            Task(title: "ABCD", detail: nil, createdDate: Date().addingTimeInterval(-TimeInterval(exactly: 60 * 5)!), completed: false),
        ]
        
        vm = TodoViewModel(tasks: testTasks)
        
        let query = ""
        
        vm.output.reloadData = { [unowned self] in
            XCTAssertEqual(self.vm.output.todoTasks.count, 4)
        }
        
        vm.input.search(with: query)
    }
    
    
}
