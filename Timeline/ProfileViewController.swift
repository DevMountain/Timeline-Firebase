//
//  ProfileViewController.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/29/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var user: User!
    var userPosts: [Post] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let user = user {
            updateWithUser(user)
        } else {
            user = UserController.currentUser()
            updateWithUser(user)
        }
        
    }

    func updateWithUser(user: User) {
        
        self.user = user
        self.title = user.username
        
        PostController.postsForUser(user) { (posts) -> Void in
            
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
        
        view.updateWithUser(user)
        
        return view
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let cell = sender as! UICollectionViewCell
        
        if let selectedIndex = collectionView.indexPathForCell(cell)?.item {
            
            if let destinationViewController = segue.destinationViewController as? PostDetailTableViewController {
                
                _ = destinationViewController.view
                
                destinationViewController.updateWithPost(userPosts[selectedIndex])
            }
        }
    }
}
