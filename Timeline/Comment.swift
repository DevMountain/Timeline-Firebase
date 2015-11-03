//
//  Comment.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/24/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

struct Comment: Equatable, FirebaseType {
    
    private let PostKey = "post"
    private let UserKey = "username"
    private let TextKey = "text"

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
    
    // MARK: FirbaseType
    
    var endpoint: String {
        
        return "/posts/\(self.postIdentifier)/comments/"
    }
    
    var jsonValue: [String: AnyObject] {
        
        return [PostKey: self.postIdentifier, UserKey: self.username, TextKey: self.text]
    }
    
    init?(json: [String: AnyObject], identifier: String) {
        
        guard let postIdentifier = json[PostKey] as? String,
            let username = json[UserKey] as? String,
            let text = json[TextKey] as? String else {
                
                self.postIdentifier = ""
                self.username = ""
                self.text = ""
                
                return nil
        }
        
        self.postIdentifier = postIdentifier
        self.username = username
        self.text = text
        self.identifier = identifier
    }

}

func ==(lhs: Comment, rhs: Comment) -> Bool {
    
    return (lhs.username == rhs.username) && (lhs.identifier == rhs.identifier)
}