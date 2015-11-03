//
//  PostDetailTableViewController.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/29/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {

    var post: Post!
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        if let post = post {
            updateWithPost(post)
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func updateWithPost(post: Post) {
        
        self.post = post
        
        self.likesLabel.text = "\(post.likes.count) likes"
        self.commentsLabel.text = "\(post.comments.count) comments"
        
        ImageController.imageForIdentifier(post.imageEndpoint) { (image) -> Void in
            self.headerImageView.image = image
        }
        
        tableView.reloadData()
    }

    @IBAction func likeTapped(sender: AnyObject) {
        
        PostController.addLikeToPost(self.post) { (success, post) -> Void in
            
            if let post = post {
                self.updateWithPost(post)
            }
        }
    }
    
    @IBAction func addCommentTapped(sender: AnyObject) {
        
        let commentAlert = UIAlertController(title: "Add Comment", message: nil, preferredStyle: .Alert)
        
        commentAlert.addTextFieldWithConfigurationHandler { (textfield) -> Void in
            textfield.placeholder = "Comment"
        }
        
        commentAlert.addAction(UIAlertAction(title: "Add Comment", style: .Default, handler: { (action) -> Void in
            
            if let text = commentAlert.textFields?.first?.text {
                
                PostController.addCommentWithTextToPost(text, post: self.post, completion: { (success, post) -> Void in
                    
                    if let post = post {
                        self.updateWithPost(post)
                    }
                })
            }
        }))
        
        commentAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        
        presentViewController(commentAlert, animated: true, completion: nil)
    }

    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return post.comments.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! PostCommentTableViewCell
        
        let comment = post.comments[indexPath.row]
        
        cell.updateWithComment(comment)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Comments"
    }

}
