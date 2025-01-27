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
    var isEditing: Bool { get }
    var creationCompleted: (() -> Void)? { get set }
    var creationDate: String { get }
    var titleString: String { get }
    var detailString: String { get }
}

protocol TaskViewInput {
    func createOrEditTask(title: String, detail: String?)
}

protocol TaskViewViewModelType {
    var input: TaskViewInput { get }
    var output: TaskViewOutput { get }
}

class TaskViewViewModel: TaskViewViewModelType, TaskViewInput, TaskViewOutput {
    var titleString: String
    
    var detailString: String
    
    var creationDate: String
    var titleIsNil: (() -> Void)?
    var isEditing: Bool
    var creationCompleted: (() -> Void)?
    
    var input: TaskViewInput { return self }
    var output: TaskViewOutput { return self }
    
    var database: Database!
    
    var editingTask: Task?
    
    init(database: Database, editingTask task: Task?) {
        self.database = database
        
        if let task = task {
            editingTask = task
            creationDate = TaskViewViewModel.CreationDateFormatter.string(from: task.createdDate)
            isEditing = true
            titleString = task.title
            detailString = task.detail ?? ""
        } else {
            isEditing = false
            creationDate = ""
            detailString = ""
            titleString = ""
        }
    }
    
    func createOrEditTask(title: String, detail: String?) {
        if isEditing {
            editTask(title: title, detail: detail)
        } else {
            createTask(title: title, detail: detail)
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
        
        creationCompleted?()
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
            
            creationCompleted?()
        }
    }
    
    static let CreationDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.medium
        return formatter
    }()
    
}
