//
//  Post.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/24/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation
import UIKit

struct Post {
    
    let imageEndpoint: String
    let caption: String?
    let username: String
    let comments: [Comment]
    let likes: [Like]
    var identifier: String?

    init(imageEndpoint: String, caption: String?, username: String = UserController.currentUser().username, comments: [Comment] = [], likes: [Like] = [], identifier: String? = nil) {
        
        self.imageEndpoint = imageEndpoint
        self.caption = caption
        self.username = username
        self.comments = comments
        self.likes = likes
    }
}