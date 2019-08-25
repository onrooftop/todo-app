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
    var database: Database!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
        var config = Realm.Configuration()
        config.inMemoryIdentifier = self.name + "_test"
        database = Database(config: config)
        
        viewModel = TaskViewViewModel(database: database, editingTask: nil)
        
        try! database.realm.write {
            database.realm.deleteAll()
        }
    }


    func testCreateTaskWithNilDetail() {
        viewModel.input.createOrEditTask(title: "Title", detail: nil)
        
        XCTAssertEqual(database.getAllTasks().count, 1)
        XCTAssertEqual(database.getAllTasks().first?.title, "Title")
        XCTAssertNil(database.getAllTasks().first?.detail)
    }
    
    func testCreateTaskWithDetail() {
        viewModel.input.createOrEditTask(title: "Title", detail: "Detail")
        
        XCTAssertEqual(database.getAllTasks().count, 1)
        XCTAssertEqual(database.getAllTasks().first?.title, "Title")
        XCTAssertEqual(database.getAllTasks().first?.detail, "Detail")
    }
    
    func testCreateTaskWithEmpty() {
        
        viewModel.output.titleIsNil = { 
            XCTAssert(true)
        }
        
        viewModel.input.createOrEditTask(title: "", detail: "")
    }
    
    func test_editing_task() {
    
        
        let task = Task()
        task.title = "Title"
        database.createOrUpdate(task: task)
        
        viewModel = TaskViewViewModel(database: database, editingTask: task)
        
        XCTAssertTrue(viewModel.output.isEditing)
        
        viewModel.input.createOrEditTask(title: "TitleEdited", detail: "DetailEdited")
        
        XCTAssertEqual(database.getAllTasks().count, 1)
        XCTAssertEqual(database.getAllTasks().first?.title, "TitleEdited")
        XCTAssertEqual(database.getAllTasks().first?.detail, "DetailEdited")
        
    }

}
