//
//  TimelineTableViewController.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/29/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {

    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        if let currentUser = UserController.sharedController.currentUser {
            
            if posts.count == 0 {
                loadTimelineForUser(currentUser)
            }
            
        } else {
            
            self.tabBarController?.performSegueWithIdentifier("toLoginSignup", sender: nil)
        }
        
    }
    
    func loadTimelineForUser(user: User) {
        PostController.fetchTimelineForUser(user) { (posts) -> Void in
            
            if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }

    @IBAction func userRefreshedTable(sender: UIRefreshControl) {
        
        loadTimelineForUser(UserController.sharedController.currentUser)
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostTableViewCell
        
        let post = posts[indexPath.row]
        
        cell.updateWithPost(post)
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            if let destinationViewController = segue.destinationViewController as? PostDetailTableViewController {
                
                _ = destinationViewController.view
                
                destinationViewController.updateWithPost(posts[indexPath.row])
            }
        }
    }
}
