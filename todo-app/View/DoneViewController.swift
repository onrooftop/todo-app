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

    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupCell()
        
        setupTableView()
        
        setupNav()
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
    }
    
    private func setupNav() {
        navigationController?.navigationBar.tintColor = .black
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Done"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "•••", style: UIBarButtonItem.Style.plain, target: self, action: #selector(optionsHandler))
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search done task"
        searchController.searchBar.tintColor = .black
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Handler
    @objc
    private func optionsHandler() {
        print("handleOptions")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: doneTaskReuseIdentifier, for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "Delete") { (action, indexPath) in
            print("Delete")
        }
        
        deleteAction.backgroundColor = Colors.ReadPersian
        
        let todoAction = UITableViewRowAction(style: UITableViewRowAction.Style.normal, title: "Todo") { (action, indexPath) in
            print("Todo")
        }
        
        todoAction.backgroundColor = Colors.BlueSteel
        
        return [deleteAction, todoAction]
    }
}

extension DoneViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}
