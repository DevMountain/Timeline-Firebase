//
//  UserSearchTableViewController.swift
//  Timeline
//
//  Created by Taylor Mott on 11/3/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    enum ViewMode: Int {
        case Friends = 0
        case All = 1
        
        func users(completion: (users:[User]?) -> Void) {
            
            switch self {
                
            case .Friends:
                UserController.followedByUser(UserController.sharedController.currentUser) { (followers) -> Void in
                    completion(users: followers)
                }
                
            case .All:
                UserController.fetchAllUsers() { (users) -> Void in
                    completion(users: users)
                }
            }
        }
    }
    
    // MARK: - Properties
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    var usersDataSource: [User] = []
    var mode: ViewMode {
        get {
            return ViewMode(rawValue: modeSegmentedControl.selectedSegmentIndex)!
        }
    }
    var searchController: UISearchController!
    
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewBasedOnMode()
        setUpSearchController()
    }
    
    func updateViewBasedOnMode() {
        mode.users() { (users) -> Void in
            if let users = users {
                self.usersDataSource = users
            } else {
                self.usersDataSource = []
            }
            
            self.tableView.reloadData()
        }
    }
    
    @IBAction func modeSegmentedControllerValueChanged() {
        updateViewBasedOnMode()
    }
    
    // MARK: - Search Controller
    
    func setUpSearchController() {
        
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UserSearchResultsTableViewController")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchTerm = searchController.searchBar.text!.lowercaseString
        
        let resultsViewController = searchController.searchResultsController as! UserSearchResultsTableViewController
        
        resultsViewController.usersResultsDataSource = usersDataSource.filter({$0.username.lowercaseString.containsString(searchTerm)})
        resultsViewController.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersDataSource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("usernameCell", forIndexPath: indexPath)
        
        let user = usersDataSource[indexPath.row]
        
        cell.textLabel?.text = user.username

        return cell
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toProfileView" {
            guard let cell = sender as? UITableViewCell else { return }
            
            if let indexPath = tableView.indexPathForCell(cell) {
                
                let user = usersDataSource[indexPath.row]
                
                let destinationViewController = segue.destinationViewController as? ProfileViewController
                destinationViewController?.user = user
                
            } else if let indexPath = (searchController.searchResultsController as? UserSearchResultsTableViewController)?.tableView.indexPathForCell(cell) {
                
                let user = (searchController.searchResultsController as! UserSearchResultsTableViewController).usersResultsDataSource[indexPath.row]
                
                let destinationViewController = segue.destinationViewController as? ProfileViewController
                destinationViewController?.user = user
            }
        }
    }
}
