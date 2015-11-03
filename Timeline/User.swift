//
//  User.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/24/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

struct User: Equatable, FirebaseType {
    
    private let UserKey = "user"
    private let BioKey = "bio"
    private let URLKey = "url"
    
    let username: String
    var bio: String?
    var url: String?
    var identifier: String?

    init(username: String, uid: String, bio: String? = nil, url: String? = nil) {

        self.username = username
        self.bio = bio
        self.url = url
        self.identifier = uid
    }
    
    // MARK: FirebaseType
    
    var endpoint: String = "users"
    
    var jsonValue: [String: AnyObject] {
        
        var json: [String: AnyObject] = [UserKey: self.username]
        
        if let bio = self.bio {
            json.updateValue(bio, forKey: BioKey)
        }
        
        if let url = self.url {
            json.updateValue(url, forKey: URLKey)
        }
        
        return json
    }
    
    init?(json: [String: AnyObject], identifier: String) {
        
        guard let username = json[UserKey] as? String else {
            
            self.username = ""
            
            return nil
        }
        
        self.username = username
        self.bio = json[BioKey] as? String
        self.url = json[URLKey] as? String
        self.identifier = identifier
    }
}

func ==(lhs: User, rhs: User) -> Bool {
    
    return (lhs.username == rhs.username) && (lhs.identifier == rhs.identifier)
}