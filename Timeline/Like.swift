//
//  Like.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/24/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

struct Like: Equatable, FirebaseType {
    
    private let UserKey = "username"
    private let PostKey = "post"

    let username: String
    let postIdentifier: String
    var identifier: String?
    
    init(username: String, postIdentifier: String, identifier: String? = nil) {
        
        self.username = username
        self.postIdentifier = postIdentifier
        self.identifier = identifier
    }
    
    // MARK: FirebaseType
    
    var endpoint: String {
        
        return "/posts/\(self.postIdentifier)/likes/"
    }
    
    var jsonValue: [String: AnyObject] {
        
        return [UserKey: self.username, PostKey: self.postIdentifier]
    }
    
    init?(json: [String: AnyObject], identifier: String) {
        
        guard let postIdentifier = json[PostKey] as? String,
            let username = json[UserKey] as? String else {
                
                self.identifier = ""
                self.postIdentifier = ""
                self.username = ""
                
                return nil
        }
        
        self.postIdentifier = postIdentifier
        self.username = username
        self.identifier = identifier
    }
}

func ==(lhs: Like, rhs: Like) -> Bool {
    
    return (lhs.username == rhs.username) && (lhs.identifier == rhs.identifier)
}