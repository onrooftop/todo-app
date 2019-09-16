//
//  DoneViewViewModel.swift
//  todo-app
//
//  Created by Panupong Kukutapan on 9/9/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation

protocol DoneViewViewModelInput {
    func todoTask(task: Task)
    func deleteTask(task: Task)
}

protocol DoneViewViewModelOutput: class {
    var reloadData: (() -> Void)? { get set }
    var tasks: [Task] { get }
}

protocol DoneViewViewModelType {
    var output: DoneViewViewModelOutput { get }
    var input: DoneViewViewModelInput { get }
}

class DoneViewViewModel: DoneViewViewModelType, DoneViewViewModelInput, DoneViewViewModelOutput  {
    var tasks: [Task]
    
    var reloadData: (() -> Void)?

    
    var output: DoneViewViewModelOutput { return self }
    var input: DoneViewViewModelInput { return self }
    
    
    var database: Database!
    
    init(database: Database) {
        self.database = database
        tasks = database.getAllTasks().filter { $0.completed == true }.sorted(by: { (t1, t2) -> Bool in
            return t1.completedDate! < t2.completedDate!
        })
        
        reloadData?()
    }
    
    func todoTask(task: Task) {
        let todoTask = Task()
        todoTask.id = task.id
        todoTask.completed = false
        todoTask.completedDate = nil
        todoTask.detail = task.detail
        todoTask.title = task.title
        
        database.createOrUpdate(task: todoTask)
        
        tasks = database.getAllTasks().filter { $0.completed == true }.sorted(by: { (t1, t2) -> Bool in
            return t1.completedDate! < t2.completedDate!
        })
        
        reloadData?()
    }
    
    func deleteTask(task: Task) {
        database.deleteTask(task: task)
        
        tasks = database.getAllTasks().filter { $0.completed == true }.sorted(by: { (t1, t2) -> Bool in
            return t1.completedDate! < t2.completedDate!
        })
        
        reloadData?()
    }
}
