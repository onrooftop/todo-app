//
//  TaskListViewModel.swift
//  todo-app
//
//  Created by Panupong Kukutapan on 11/8/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation

protocol TaskListInput {
    
}

protocol TaskListOutput {
    var titleText: String { get }
    var completed: Bool { get }
    var detailText: String { get }
    var amountOfTimeText: String { get }
}

protocol TaskListViewModelType {
    var input: TaskListInput { get }
    var output: TaskListOutput { get }
}

class TaskListViewModel: TaskListViewModelType, TaskListInput, TaskListOutput {
    
    var amountOfTimeText: String
    var detailText: String
    var completed: Bool
    var titleText: String
    
    var input: TaskListInput { return self }
    var output: TaskListOutput { return self }
    
    
    
    init(task: Task) {
        titleText = task.title
        completed = task.completed
        detailText = task.detail ?? ""
        
        if completed {
            amountOfTimeText = TaskListViewModel.TimePassFormatter.string(from: task.completedDate ?? Date(), to: Date()) ?? "-"
        } else {
            amountOfTimeText = TaskListViewModel.TimePassFormatter.string(from: task.createdDate, to: Date()) ?? "-"
        }
        
    }
    
    static let TimePassFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.second,. minute, .hour,.weekOfMonth, .month, .year]
        
        formatter.maximumUnitCount = 1
        
        formatter.unitsStyle = DateComponentsFormatter.UnitsStyle.full
        
        return formatter
    }()
    
}
