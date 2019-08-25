//
//  TaskViewViewModelTest.swift
//  todo-appTests
//
//  Created by Panupong Kukutapan on 25/8/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import XCTest
import RealmSwift

@testable import todo_app

class TaskViewViewModelTest: XCTestCase {
    
    var viewModel: TaskViewViewModelType!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        viewModel = TaskViewViewModel(database: Database.shared, editingTask: nil)
        
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        
        try! Database.shared.realm.write {
            Database.shared.realm.deleteAll()
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateTaskWithNilDetail() {
        viewModel.input.createTask(title: "Title", detail: nil)
        
        XCTAssertEqual(Database.shared.getAllTasks().count, 1)
        XCTAssertEqual(Database.shared.getAllTasks().first?.title, "Title")
        XCTAssertNil(Database.shared.getAllTasks().first?.detail)
    }
    
    func testCreateTaskWithDetail() {
        viewModel.input.createTask(title: "Title", detail: "Detail")
        
        XCTAssertEqual(Database.shared.getAllTasks().count, 1)
        XCTAssertEqual(Database.shared.getAllTasks().first?.title, "Title")
        XCTAssertEqual(Database.shared.getAllTasks().first?.detail, "Detail")
    }
    
    func testCreateTaskWithEmpty() {
        
        viewModel.output.titleIsNil = { 
            XCTAssert(true)
        }
        
        viewModel.input.createTask(title: "", detail: "")
    }
    
    func test_editing_task() {
        
        viewModel.output.isEditing = { (editing) in
            XCTAssertTrue(editing)
        }
        
        let task = Task()
        task.title = "Title"
        Database.shared.createOrUpdate(task: task)
        
        viewModel = TaskViewViewModel(database: Database.shared, editingTask: task)
        
        viewModel.input.editTask(title: "TitleEdited", detail: "DetailEdited")
        
        XCTAssertEqual(Database.shared.getAllTasks().count, 1)
        XCTAssertEqual(Database.shared.getAllTasks().first?.title, "TitleEdited")
        XCTAssertEqual(Database.shared.getAllTasks().first?.detail, "DetailEdited")
        
    }

}
