//
//  PostCommentTableViewCell.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/30/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class PostCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateWithComment(comment: Comment) {
        
        usernameLabel.text = comment.username
        commentLabel.text = comment.text
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
