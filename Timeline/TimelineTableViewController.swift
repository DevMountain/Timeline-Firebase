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
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }
}
