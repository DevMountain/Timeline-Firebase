//
//  UserListSearchTableViewController.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/29/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class UserListSearchTableViewController: UITableViewController, UISearchResultsUpdating {

    enum ViewMode: Int {
        case Friends
        case All
        
        func users(completion: (users:[User]?) -> Void) {
            
            switch self {
                
            case .Friends:
                UserController.followedByUser(UserController.sharedController.currentUser, completion: { (followers) -> Void in
                    completion(users: followers)
                })
                
            case .All:
                UserController.fetchAllUsers({ (users) -> Void in
                    completion(users: users)
                })
            }
        }
    }
    
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    var mode: ViewMode {
        
        return ViewMode(rawValue: modeSegmentedControl.selectedSegmentIndex)!
    }
    
    var usersDataSource: [User] = []
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViewForMode(mode)
        
        setUpSearchController()
    }

    @IBAction func selectedIndexChanged(sender: UISegmentedControl) {
        
        updateViewForMode(mode)
    }
    
    func updateViewForMode(mode: ViewMode) {
        
        mode.users { (users) -> Void in
            
            if let users = users {
                self.usersDataSource = users
            } else {
                self.usersDataSource = []
            }
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Search Controller
    
    func setUpSearchController() {
        
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("userSearchResults")
                
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchTerm = searchController.searchBar.text!.lowercaseString
        
        let resultsViewController = searchController.searchResultsController as! UserListSearchResultsTableViewController
        
        resultsViewController.usersDataSource = self.usersDataSource.filter({$0.username.lowercaseString.containsString(searchTerm)})
        resultsViewController.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.usersDataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
        
        let user = usersDataSource[indexPath.row]
        
        cell.textLabel?.text = user.username
        
        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let sender = sender as! UITableViewCell
        
        var selectedUser: User
        
        // if we get an indexPath from the search results controller, use that userDataSource
        // else, use self.userDataSource
        
        if let indexPath = (searchController.searchResultsController as? UserListSearchResultsTableViewController)?.tableView.indexPathForCell(sender) {
            
            let usersDataSource = (searchController.searchResultsController as! UserListSearchResultsTableViewController).usersDataSource
            
            selectedUser = usersDataSource[indexPath.row]
        } else {
            
            let indexPath = tableView.indexPathForCell(sender)!
            selectedUser = self.usersDataSource[indexPath.row]
        }
        
        let destinationViewController = segue.destinationViewController as! ProfileViewController
        
        destinationViewController.user = selectedUser
    }
}
