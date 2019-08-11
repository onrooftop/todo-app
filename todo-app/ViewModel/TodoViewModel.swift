//
//  TodoViewModel.swift
//  todo-app
//
//  Created by Panupong Kukutapan on 3/8/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation

protocol TodoViewModelInput {
    func createTask(title: String, detail: String)
    func deleteTask(at index: Int)
    func doneTask(at index: Int)
    func search(with query: String)
}

protocol TodoViewModelOutput: class {
    var todoTasks: [Task] { get }
    var reloadData: (() -> Void)? { get set }
    var isSearching: Bool { get }
}

protocol TodoViewModelType {
    var input: TodoViewModelInput { get }
    var output: TodoViewModelOutput { get }
}

class TodoViewModel: TodoViewModelType, TodoViewModelInput, TodoViewModelOutput{
    
    var isSearching: Bool
    var reloadData: (() -> Void)?
    var todoTasks: [Task]
    
    private var taskList = [Task]()
    private var searchList = [Task]()
    
    var input: TodoViewModelInput { return self }
    var output: TodoViewModelOutput { return self }
    
    init(tasks: [Task]) {
        taskList = tasks.filter{$0.completed == false}
        todoTasks = taskList
        isSearching = false
    }

    func createTask(title: String, detail: String) {
        let task = Task(title: title, detail: detail, createdDate: Date(), completed: false)
        taskList.append(task)
        todoTasks = taskList
        reloadData?()
    }
    
    func deleteTask(at index: Int) {
        taskList.remove(at: index)
        todoTasks = taskList
        reloadData?()
    }
    
    func doneTask(at index: Int) {
        taskList[index].completed = true
        taskList[index].completedDate = Date()
        taskList.remove(at: index)
        todoTasks = taskList
        reloadData?()
    }
    
    func search(with query: String) {
        isSearching = !query.isEmpty
        
        if isSearching {
            searchList = taskList.filter{$0.title.lowercased().contains(query.lowercased())}
            todoTasks = searchList
        } else {
            todoTasks = taskList
        }
        
        reloadData?()
    
    }
}
