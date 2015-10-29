//
//  PostController.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/24/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class PostController {
    
    static func addPost(image: UIImage, caption: String?, completion: (post: Post?) -> Void) {
        
        completion(post: mockPosts().first)
    }
    
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        
        completion(post: mockPosts().first)
    }
    
    static func postsForUser(user: User, completion: (posts: [Post]?) -> Void) {
        
        completion(posts: PostController.mockPosts())
    }
    
    static func deletePost(post: Post, completion: (success: Bool) -> Void) {
        
        completion(success: true)
    }
    
    static func addCommentToPost(comment: Comment, post: Post, completion: (success: Bool, post: Post?) -> Void) {
    
        completion(success: true, post: post)
    }
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        
        completion(success: true, post: mockPosts().first)
    }
    
    static func addLikeToPost(like: Like, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
        completion(success: true, post: post)
    }
    
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {

        completion(success: true, post: mockPosts().first)
    }
    
    static func mockPosts() -> [Post] {

        let sampleImageIdentifier = "-K1l4125TYvKMc7rcp5e"
        
        let post1 = Post(imageEndpoint: sampleImageIdentifier, caption: "Awesome shot of the beach.")
        let post2 = Post(imageEndpoint: sampleImageIdentifier, caption: "Great lookin' kids!")
        let post3 = Post(imageEndpoint: sampleImageIdentifier, caption: "Love the way she looks when she smiles like that.")
        
        return [post1, post2, post3]
    }
    
    
}