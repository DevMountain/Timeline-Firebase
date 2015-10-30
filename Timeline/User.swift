//
//  User.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/24/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

struct User: Equatable {
    
    let username: String
    var bio: String?
    var url: String?
    var identifier: String?

    init(username: String, bio: String? = nil, url: String? = nil) {

        self.identifier = username
        self.username = username
        self.bio = bio
        self.url = url
    }
}

func ==(lhs: User, rhs: User) -> Bool {
    
    return (lhs.username == rhs.username) && (lhs.identifier == rhs.identifier)
}