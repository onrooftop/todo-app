//
//  TodoViewController.swift
//  todo-app
//
//  Created by Panupong Kukutapan on 29/7/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import UIKit

private let todoTaskReuseIdentifier = "todoTaskReuseIdentifier"

class TodoViewController: UITableViewController {

    var searchController:UISearchController!
    
    var todoViewModel: TodoViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        setupCell()
        
        setupTableView()
        
        setupNav()
        
        
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
        tableView.register(TaskViewCell.self, forCellReuseIdentifier: todoTaskReuseIdentifier)
    }
    
    private func setupTableView() {
        tableView.rowHeight = 64
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
    }
    
    @objc
    private func refresh(sender: UIRefreshControl) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
            self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    private func setupNav() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Todo"
        let moreButtonItem = UIBarButtonItem(title: "•••", style: UIBarButtonItem.Style.plain, target: self, action: #selector(optionsHandler))
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTaskHandler))
        navigationItem.rightBarButtonItems = [moreButtonItem, addButtonItem]
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search task"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .black
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
//        definesPresentationContext = true
    }
    
    func setupViewModel() {
        todoViewModel = TodoViewModel(database: Database())
        
        todoViewModel.output.reloadData = reloadData()
    }
    
    // MARK: - Handlers
    
    @objc
    func addTaskHandler() {
        navigationController?.pushViewController(TaskViewController(), animated: true)
    }
    
    @objc
    func optionsHandler() {
        print("moreHandler")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoViewModel.output.todoTasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: todoTaskReuseIdentifier, for: indexPath) as! TaskViewCell
        let task = todoViewModel.output.todoTasks[indexPath.row]
        cell.viewModel = TaskListViewModel(task: task)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "Delete") { (action, indexPath) in
            
            let alertController = UIAlertController(title: "Delete", message: "Are you sure to delete this task", preferredStyle: UIAlertController.Style.alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { (action) in
                self.todoViewModel.input.deleteTask(at: indexPath.row)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) in
                print("Cancel Delete")
            })
            
            alertController.addAction(deleteAction)
            
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        deleteAction.backgroundColor = Colors.ReadPersian
        
        let doneAction = UITableViewRowAction(style: UITableViewRowAction.Style.normal, title: "Done") { (action, indexPath) in
            
            let alertController = UIAlertController(title: "Move to Done", message: "Are you sure to move this task to be Done", preferredStyle: UIAlertController.Style.alert)
            
            let doneAction = UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { (action) in
                self.todoViewModel.input.doneTask(at: indexPath.row)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) in
                print("Cancel Delete")
            })
            
            alertController.addAction(doneAction)
            
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        doneAction.backgroundColor = Colors.BlueSteel
        
        return [deleteAction, doneAction]
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: UIContextualAction.Style.normal, title: "Edit") { (action, view, success) in
            
            success(true)
            
            let taskVC = TaskViewController()
            let task = self.todoViewModel.output.todoTasks[indexPath.row]
            taskVC.viewModel = TaskViewViewModel(database: Database(), editingTask: task)
            
            self.navigationController?.pushViewController(taskVC, animated: true)
        }

        let config = UISwipeActionsConfiguration(actions: [editAction])
        
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }

}

extension TodoViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        todoViewModel.input.search(with: searchController.searchBar.text ?? "")
    }
}

extension TodoViewController {
    func reloadData() -> (() -> Void) {
        return { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
