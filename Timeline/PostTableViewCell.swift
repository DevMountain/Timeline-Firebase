//
//  PostTableViewCell.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/30/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateWithPost(post: Post) {
        
        self.likesLabel.text = "\(post.likes.count) likes"
        self.commentsLabel.text = "\(post.comments.count) comments"
        
        ImageController.imageForIdentifier(post.imageEndpoint) { (image) -> Void in
            self.postImageView.image = image
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
