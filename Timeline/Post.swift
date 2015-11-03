//
//  Post.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/24/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation
import UIKit

struct Post: Equatable, FirebaseType {
    
    private let UserKey = "username"
    private let ImageEndpointKey = "imageEndpoint"
    private let CaptionKey = "caption"
    private let CommentsKey = "comments"
    private let LikesKey = "likes"
    
    let imageEndpoint: String
    let caption: String?
    let username: String
    let comments: [Comment]
    let likes: [Like]
    var identifier: String?

    init(imageEndpoint: String, caption: String?, username: String = UserController.sharedController.currentUser.username, comments: [Comment] = [], likes: [Like] = [], identifier: String? = nil) {
        
        self.imageEndpoint = imageEndpoint
        self.caption = caption
        self.username = username
        self.comments = comments
        self.likes = likes
    }
    
    // MARK: FirebaseType
    
    var endpoint: String  = "posts"
    
    var jsonValue: [String: AnyObject] {
        
        var json: [String: AnyObject] = [UserKey: self.username, ImageEndpointKey: self.imageEndpoint, CommentsKey: self.comments.map({$0.jsonValue}), LikesKey: self.likes.map({$0.jsonValue})]
        
        if let caption = self.caption {
            
            json.updateValue(caption, forKey: CaptionKey)
        }
        
        return json
    }
    
    init?(json: [String: AnyObject], identifier: String) {
        
        guard let username = json[UserKey] as? String,
            let imageEndpoint = json[ImageEndpointKey] as? String else {
                
                self.imageEndpoint = ""
                self.caption = ""
                self.username = ""
                self.identifier = ""
                
                return nil
        }
        
        self.imageEndpoint = imageEndpoint
        self.caption = json[CaptionKey] as? String
        self.username = username
        self.identifier = identifier
        
        if let commentDictionaries = json[CommentsKey] as? [String: AnyObject] {
            self.comments = commentDictionaries.flatMap({Comment(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
        } else {
            self.comments = []
        }
        
        if let likeDictionaries = json[LikesKey] as? [String: AnyObject] {
            self.likes = likeDictionaries.flatMap({Like(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
        } else {
            self.likes = []
        }
    }

}

func ==(lhs: Post, rhs: Post) -> Bool {
    
    return (lhs.username == rhs.username) && (lhs.identifier == rhs.identifier)
}