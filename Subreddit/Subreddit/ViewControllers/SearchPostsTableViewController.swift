//
//  SearchPostsTableViewController.swift
//  Subreddit
//
//  Created by Eric Andersen on 9/4/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

class SearchPostsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text else { return }
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        PostController.shared.fetchPosts(by: searchTerm) {
            DispatchQueue.main.async {
                self.title = "r/\(searchTerm)"
                self.tableView.reloadData()
            }
        }
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PostController.shared.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let post = PostController.shared.posts[indexPath.row]
        
        PostController.shared.fetchImage(at: post.thumbnailEndpoint) { (image) in
            DispatchQueue.main.async {
                // Configure the cell...
                cell.post = post
                if let currentIndexPath = self.tableView?.indexPath(for: cell),
                    currentIndexPath == indexPath {
                    cell.thumbnail = image
                } else {
                    print("Got image for now-reused cell")
                    return
                }
            }
        }
        return cell
    }
}
