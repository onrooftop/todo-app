//
//  DoneViewController.swift
//  todo-app
//
//  Created by Panupong Kukutapan on 29/7/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import UIKit

class DoneViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        
        
        setupNav()
    }

    // MARK: - Set up
    
    private func setupNav() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Done"
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }


}
