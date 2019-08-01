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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Done"
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search done task"
        searchController.searchBar.tintColor = .black
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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
}

extension DoneViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}
