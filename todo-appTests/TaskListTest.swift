//
//  TaskListTest.swift
//  todo-appTests
//
//  Created by Panupong Kukutapan on 11/8/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import XCTest
@testable import todo_app

class TaskListTest: XCTestCase {
    
    var vm: TaskListViewModelType!
    var task: Task!
    
    override func setUp() {
        task = Task(title: "Title", detail: "detial", createdDate: Date(), completed: false)
    }

    override func tearDown() {
        
    }

    func testTitleTextShouldBeTitle() {
        
        vm = TaskListViewModel(task: task)
        
        XCTAssertEqual(vm.output.titleText, "Title")
        
    }
    
    func testCompletedShouleBeFalse() {
        
        task.completed = false
        
        vm = TaskListViewModel(task: task)
        
        XCTAssertFalse(vm.output.completed)
    }
    
    func testCompletedShouldBeTrue() {
        task.completed = true
        
        vm = TaskListViewModel(task: task)
        
        XCTAssertTrue(vm.output.completed)
    }
    
    func testDetialTextShouldBeEmpty() {
        task.detail = nil
        
        vm = TaskListViewModel(task: task)
        
        XCTAssertEqual(vm.output.detailText, "")
    }
    
    func testDetialTextShouldBeDetial() {
        task.detail = "detail"
        
        vm = TaskListViewModel(task: task)
        
        XCTAssertEqual(vm.output.detailText, "detail")
    }
    
    func testAmountOfTimeTextShouldBe2minutes() {
        
        let twoMinutesInSecond = 60 * 2
        
        task.createdDate = Date().addingTimeInterval(-TimeInterval.init(exactly: twoMinutesInSecond)!)
        
        vm = TaskListViewModel(task: task)
        
        XCTAssertEqual(vm.output.amountOfTimeText, "2 minutes")
    }
    
    func testAmountOfTimeTextShouldBe1minute() {
        
        let timeInSecond = 60
        
        task.createdDate = Date().addingTimeInterval(-TimeInterval.init(exactly: timeInSecond)!)
        
        vm = TaskListViewModel(task: task)
        
        XCTAssertEqual(vm.output.amountOfTimeText, "1 minute")
    }
    
    func testAmountOfTimeTextShouldBe3weeks() {
        
        let timeInSecond = Double(60 * 60 * 24 * 7 * 3)
        
        task.createdDate = Date().addingTimeInterval(-TimeInterval.init(exactly: timeInSecond)!)
        
        vm = TaskListViewModel(task: task)
        
        XCTAssertEqual(vm.output.amountOfTimeText, "3 weeks")
    }
    
    func testAmountOfTimeTextShouldBe1year() {
        
        let timeInSecond = Double(60 * 60 * 24 * 30 * 15) 
        
        task.createdDate = Date().addingTimeInterval(-TimeInterval.init(exactly: timeInSecond)!)
        
        vm = TaskListViewModel(task: task)
        
        XCTAssertEqual(vm.output.amountOfTimeText, "1 year")
    }
    
    func testAmountOfTimeTextOfCompletedTaskShouldBe5minutes() {
        let timeInSecond = 60 * 5
        
        task.completed = true
        
        task.createdDate = Date().addingTimeInterval(-TimeInterval(exactly: timeInSecond * 2)!)
        
        task.completedDate = Date().addingTimeInterval(-TimeInterval(exactly: timeInSecond)!)
        
        vm = TaskListViewModel(task: task)
        
        XCTAssertEqual(vm.output.amountOfTimeText, "5 minutes")
    }
    
}
