//
//  PostListTableViewController.swift
//  MyFavoriteApp
//
//  Created by Brady Bentley on 12/12/18.
//  Copyright © 2018 Brady. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // MARK: - Action
    @IBAction func addPostButtonTapped(_ sender: Any) {
    }
    @IBAction func refreshButtonTapped(_ sender: Any) {
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    
}
