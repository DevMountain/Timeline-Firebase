//
//  UserSearchResultsTableViewController.swift
//  Timeline
//
//  Created by Taylor Mott on 11/4/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class UserSearchResultsTableViewController: UITableViewController {
    
    var usersResultsDataSource: [User] = []

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersResultsDataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("usernameCell", forIndexPath: indexPath)

        let user = usersResultsDataSource[indexPath.row]
        
        cell.textLabel?.text = user.username

        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        self.presentingViewController?.performSegueWithIdentifier("toProfileView", sender: cell)
    }
}
