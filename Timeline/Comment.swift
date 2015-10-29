//
//  Comment.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/24/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

struct Comment {

    let username: String
    let text: String
    let postIdentifier: String
    var identifier: String?

    init(username: String, text: String, postIdentifier: String, identifier: String? = nil) {
        
        self.postIdentifier = postIdentifier
        self.username = username
        self.text = text
        self.identifier = identifier
    }
}