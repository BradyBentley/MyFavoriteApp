//
//  PostListTableViewController.swift
//  MyFavoriteApp
//
//  Created by Brady Bentley on 12/12/18.
//  Copyright © 2018 Brady. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    var posts: [Post] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadPosts()

    }
    
    fileprivate func reloadPosts() {
        PostController.fetchPosts { (posts) in
            DispatchQueue.main.async {
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UIAlertController
    func presentAddPostController() {
        let alertController = UIAlertController(title: "Favorite App?", message: nil, preferredStyle: .alert)
        alertController.addTextField { (favoriteAppTextField) in
            favoriteAppTextField.placeholder = "Favorite App..."
        }
        alertController.addTextField { (nameTextField) in
            nameTextField.placeholder = "Name..."
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addPostAction = UIAlertAction(title: "Add Post", style: .default) { (_) in
            guard let favApp = alertController.textFields?[0].text, !favApp.isEmpty,
                let name = alertController.textFields?[1].text, !name.isEmpty else { return }
            PostController.postReason(favApp: favApp, name: name, completion: { (success) in
                if success {
                    self.reloadPosts()
                } else {
                    DispatchQueue.main.async {
                        self.presentFailedToPostAlert()
                    }
                }
            })
            
        }
        alertController.addAction(dismissAction)
        alertController.addAction(addPostAction)
        self.present(alertController, animated: true)
        
    }
    
    func presentFailedToPostAlert() {
        let alertController = UIAlertController(title: "Oooops", message: "Something went wrong saving your favorite App to the server", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true)
    }
    
    // MARK: - Action
    @IBAction func addPostButtonTapped(_ sender: Any) {
        presentAddPostController()
    }
    @IBAction func refreshButtonTapped(_ sender: Any) {
        reloadPosts()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.name
        cell.detailTextLabel?.text = post.favApp
        return cell
    }
}
