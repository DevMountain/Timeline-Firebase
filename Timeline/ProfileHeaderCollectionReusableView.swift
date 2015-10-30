//
//  ProfileHeaderCollectionReusableView.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/30/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var urlButton: UIButton!
    @IBOutlet weak var followUserButton: UIButton!
    
    func updateWithUser(user: User) {
        
        ImageController.imageForIdentifier(user.identifier!) { (image) -> Void in
            self.imageView.image = image
        }
        
        bioLabel.text = user.bio
        
        if user.bio == nil {
            bioLabel.removeFromSuperview()
        }
        
        if user.url == nil {
            urlButton.removeFromSuperview()
        }
        
        if user == UserController.currentUser() {
            followUserButton.removeFromSuperview()
        } else {
            UserController.userFollowedByUser(user, followedBy: UserController.currentUser()) { (follows) -> Void in
                
                if follows {
                    self.followUserButton.setTitle("Unfollow", forState: .Normal)
                }
            }
        }
    }
}
