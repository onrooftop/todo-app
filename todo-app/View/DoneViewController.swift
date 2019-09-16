//
//  DoneViewController.swift
//  todo-app
//
//  Created by Panupong Kukutapan on 29/7/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import UIKit

private let doneTaskReuseIdentifier = "doneTaskReuseIdentifier"

class DoneViewController: UITableViewController {
    
    var viewModel: DoneViewViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupCell()
        
        setupTableView()
        
        setupNav()
        
        setupViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        setupViewModel()
        tableView.reloadData()
    }

    
    // MARK: - Set up
    
    private func setupView() {
        view.backgroundColor = UIColor(white: 0.90, alpha: 1)
    }
    
    private func setupCell() {
        tableView.register(TaskViewCell.self, forCellReuseIdentifier: doneTaskReuseIdentifier)
    }
    
    private func setupTableView() {
        tableView.rowHeight = 64
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
    }
    
    private func setupNav() {
        navigationController?.navigationBar.tintColor = .black
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Done"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "•••", style: UIBarButtonItem.Style.plain, target: self, action: #selector(optionsHandler))
        
    }
    
    private func setupViewModel() {
        viewModel = DoneViewViewModel(database: Database())
        viewModel.output.reloadData = reloadData()
    }
    
    // MARK: - Handler
    @objc
    private func optionsHandler() {
        print("handleOptions")
    }
    
    func reloadData() -> (() -> Void) {
        return { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.output.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: doneTaskReuseIdentifier, for: indexPath) as! TaskViewCell
        
        let task = viewModel.output.tasks[indexPath.row]
        
        cell.viewModel = TaskListViewModel(task: task)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "Delete") { (action, indexPath) in
            
            let alertController = UIAlertController(title: "Delete", message: "Are you sure to delete this task", preferredStyle: UIAlertController.Style.alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { (action) in
                
                let task = self.viewModel.output.tasks[indexPath.row]
                
                self.viewModel.input.deleteTask(task: task)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) in
                print("Cancel Delete")
            })
            
            alertController.addAction(deleteAction)
            
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        deleteAction.backgroundColor = Colors.ReadPersian
        
        let todoAction = UITableViewRowAction(style: UITableViewRowAction.Style.normal, title: "Todo") { (action, indexPath) in
            
            let alertController = UIAlertController(title: "Move to Todo", message: "Are you sure to move this task to be Todo", preferredStyle: UIAlertController.Style.alert)
            
            let todoAction = UIAlertAction(title: "Todo", style: UIAlertAction.Style.default, handler: { (action) in
                
                let task = self.viewModel.output.tasks[indexPath.row]
                
                self.viewModel.input.todoTask(task: task)
                
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) in
                print("Cancel Todo")
            })
            
            alertController.addAction(todoAction)
            
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        todoAction.backgroundColor = Colors.BlueSteel
        
        return [deleteAction, todoAction]
    }
    
    @objc
    private func refresh(sender: UIRefreshControl) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
}
