//
//  ProfileViewController.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/29/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit
import SafariServices

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ProfileHeaderCollectionReusableViewDelegate {

    var user: User!
    var userPosts: [Post] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if user == nil {
            user = UserController.sharedController.currentUser
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UserController.userForIdentifier(user.identifier!) { (user) -> Void in
            self.updateWithUser(user!)
        }
    }

    func updateWithUser(user: User) {
        
        self.user = user
        self.title = user.username
        
        if user != UserController.sharedController.currentUser {

            // as of writing there is no system way to remove a bar button item
            // disables and hides the button
            
            self.navigationItem.rightBarButtonItem?.enabled = false
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clearColor()
            
            self.navigationItem.leftBarButtonItem?.enabled = false
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clearColor()
        }
        
        PostController.postsForUser(user.username) { (posts) -> Void in
            
            if let posts = posts {
                self.userPosts = posts
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return userPosts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
        let post = userPosts[indexPath.item]
        
        item.updateWithImageIdentifier(post.imageEndpoint)
        
        return item
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "profileHeaderView", forIndexPath: indexPath) as! ProfileHeaderCollectionReusableView
        
        view.delegate = self
        
        view.updateWithUser(user)
        
        return view
    }
    
    //MARK: - Reusable View Delegate
    
    func userTappedURLButton(sender: UIButton) {
        
        if let profileURL = NSURL(string: user.url!) {
            
            let safariViewController = SFSafariViewController(URL: profileURL)
            
            presentViewController(safariViewController, animated: true, completion: nil)
        }
    }
    
    func userTappedFollowActionButton(sender: UIButton) {
        
        UserController.userFollowsUser(UserController.sharedController.currentUser, followsUser: user) { (follows) -> Void in
            
            if follows {
                UserController.unfollowUser(self.user, completion: { (success) -> Void in
                    
                    self.updateWithUser(self.user)
                })
            } else {
                UserController.followUser(self.user, completion: { (success) -> Void in
                    
                    self.updateWithUser(self.user)
                })
            }
        }
    }

    @IBAction func userTappedLogoutButton(sender: AnyObject) {
        
        UserController.logoutCurrentUser()
        tabBarController?.selectedViewController = tabBarController?.viewControllers![0]
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        
        if segue.identifier == "toEditProfile" {
            
            if let destinationViewController = segue.destinationViewController as? LoginSignupViewController {
                
                _ = destinationViewController.view
                
                destinationViewController.updateWithUser(self.user)
            }
        }
        
        if segue.identifier == "toPostDetail" {
            let cell = sender as! UICollectionViewCell
            
            if let selectedIndex = collectionView.indexPathForCell(cell)?.item {
                
                if let destinationViewController = segue.destinationViewController as? PostDetailTableViewController {
                    
                    _ = destinationViewController.view
                    
                    destinationViewController.updateWithPost(userPosts[selectedIndex])
                }
            }
        }
    }
}
