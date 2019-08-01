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
        tableView.register(TaskViewCell.self, forCellReuseIdentifier: todoTaskReuseIdentifier)
    }
    
    private func setupTableView() {
        tableView.rowHeight = 64
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
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
    
    // MARK: - Handlers
    
    @objc
    func addTaskHandler() {
        print("addTaskHandler")
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
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: todoTaskReuseIdentifier, for: indexPath) as! TaskViewCell
        
        return cell
    }

}

extension TodoViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
    }
}
