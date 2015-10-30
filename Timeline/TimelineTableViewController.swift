//
//  TimelineTableViewController.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/29/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if UserController.currentUser() == nil {
            
            self.tabBarController?.performSegueWithIdentifier("toLoginSignup", sender: nil)
        }
        
        Timeline.sharedTimeline.posts
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return Timeline.sharedTimeline.posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostTableViewCell
        
        let post = Timeline.sharedTimeline.posts[indexPath.row]
        
        cell.updateWithPost(post)
        
        return cell
    }
}
