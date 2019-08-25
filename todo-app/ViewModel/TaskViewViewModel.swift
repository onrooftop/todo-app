//
//  TaskViewViewModel.swift
//  todo-app
//
//  Created by Panupong Kukutapan on 25/8/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation

protocol TaskViewOutput: class {
    var titleIsNil: (() -> Void)? { get set }
    var isEditing: ((Bool) -> Void)? { get set }
}

protocol TaskViewInput {
    func createTask(title: String, detail: String?)
    func editTask(title: String, detail: String?)
}

protocol TaskViewViewModelType {
    var input: TaskViewInput { get }
    var output: TaskViewOutput { get }
}

class TaskViewViewModel: TaskViewViewModelType, TaskViewInput, TaskViewOutput {
    var titleIsNil: (() -> Void)?
    var isEditing: ((Bool) -> Void)?
    
    var input: TaskViewInput { return self }
    var output: TaskViewOutput { return self }
    
    var database: Database!
    
    var editingTask: Task?
    
    init(database: Database, editingTask task: Task?) {
        self.database = database
        
        if let task = task {
            editingTask = task
            isEditing?(true)
        } else {
            isEditing?(false)
        }
    }
    
    func createTask(title: String, detail: String?) {
        
        if (title.isEmpty) {
            titleIsNil?()
            return
        }
        
        let task = Task()
        
        task.title = title
        
        
        task.detail = detail
        
        database.createOrUpdate(task: task)
    }
    
    func editTask(title: String, detail: String?) {
        if (title.isEmpty) {
            titleIsNil?()
            return
        }
        
        if let editingTask = editingTask {
            let task = Task()
            task.title = title
            task.detail = detail
            task.completed = editingTask.completed
            task.createdDate = Date()
            task.completedDate = editingTask.completedDate
            task.id = editingTask.id
            
            database.createOrUpdate(task: task)
        }
    
    }
    
}
