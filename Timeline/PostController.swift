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
    
    static func fetchTimelineForUser(user: User, completion: (posts: [Post]?) -> Void) {
        
        UserController.followedByUser(user) { (followed) -> Void in
            
            if let followed = followed {
                
                var allPosts: [Post] = []
                
                let dispatchGroup = dispatch_group_create()
                
                dispatch_group_enter(dispatchGroup)
                
                postsForUser(UserController.sharedController.currentUser.username, completion: { (posts) -> Void in
                    
                    if let posts = posts {
                        allPosts += posts
                    }
                    
                    dispatch_group_leave(dispatchGroup)
                })
                
                for user in followed {
                    
                    dispatch_group_enter(dispatchGroup)
                    
                    postsForUser(user.username, completion: { (posts) -> Void in
                        
                        if let posts = posts {
                            allPosts += posts
                        }
                        
                        dispatch_group_leave(dispatchGroup)
                    })
                }
                
                dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), { () -> Void in
                    
                    let orderedPosts = orderPosts(allPosts)
                    
                    completion(posts: orderedPosts)
                })
            }
        }
    }
    
    static func addPost(image: UIImage, caption: String?, completion: (post: Post?) -> Void) {
        
        ImageController.uploadImage(image) { (identifier) -> Void in
            
            if let identifier = identifier {
                var post = Post(imageEndpoint: identifier, caption: caption)
                post.save()
                completion(post: post)
            } else {
                completion(post: nil)
            }
        }
    }
    
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        
        FirebaseController.dataAtEndpoint("posts/\(identifier)") { (data) -> Void in
            
            if let data = data as? [String: AnyObject] {
                let post = Post(json: data, identifier: identifier)
                
                completion(post: post)
            } else {
                completion(post: nil)
            }
        }
    }
    
    static func postsForUser(username: String, completion: (posts: [Post]?) -> Void) {
        FirebaseController.base.childByAppendingPath("posts").queryOrderedByChild("username").queryEqualToValue(username).observeSingleEventOfType(.Value, withBlock: { snapshot in
            

            if let postDictionaries = snapshot.value as? [String: AnyObject] {
                
                let posts = postDictionaries.flatMap({Post(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
                
                let orderedPosts = orderPosts(posts)
                
                completion(posts: orderedPosts)
            
            } else {
                
                completion(posts: nil)
            }
        })
        
    }
    
    static func deletePost(post: Post, completion: (success: Bool) -> Void) {
        
        post.delete()
        
        completion(success: true)
    }
    
    static func addCommentWithTextToPost(text: String, post: Post, completion: (success: Bool, post: Post?) -> Void?) {
        
        if let postIdentifier = post.identifier {
            
            var comment = Comment(username: UserController.sharedController.currentUser.username, text: text, postIdentifier: postIdentifier)
            comment.save()
            
            PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
                completion(success: true, post: post)
            }
        } else {
            
            var post = post
            post.save()
            var comment = Comment(username: UserController.sharedController.currentUser.username, text: text, postIdentifier: post.identifier!)
            comment.save()
            
            PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
                completion(success: true, post: post)
            }
        }
    }
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        
        comment.delete()
        
        PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
            completion(success: true, post: post)
        }
    }
    
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
        if let postIdentifier = post.identifier {
            
            var like = Like(username: UserController.sharedController.currentUser.username, postIdentifier: postIdentifier)
            like.save()
            
        } else {
            
            var post = post
            post.save()
            var like = Like(username: UserController.sharedController.currentUser.username, postIdentifier: post.identifier!)
            like.save()
        }
        
        PostController.postFromIdentifier(post.identifier!, completion: { (post) -> Void in
            completion(success: true, post: post)
        })
    }
    
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {

        like.delete()
        
        PostController.postFromIdentifier(like.postIdentifier) { (post) -> Void in
            completion(success: true, post: post)
        }
    }
    
    static func orderPosts(posts: [Post]) -> [Post] {
        
        // sorts posts chronologically using Firebase identifiers
        return posts.sort({$0.0.identifier > $0.1.identifier})
    }
    
    static func mockPosts() -> [Post] {

        let sampleImageIdentifier = "-K1l4125TYvKMc7rcp5e"
        
        let like1 = Like(username: "darth", postIdentifier: "1234")
        let like2 = Like(username: "look", postIdentifier: "4566")
        let like3 = Like(username: "em0r0r", postIdentifier: "43212")
        
        let comment1 = Comment(username: "ob1kenob", text: "use the force", postIdentifier: "1234")
        let comment2 = Comment(username: "darth", text: "join the dark side", postIdentifier: "4566")
        
        let post1 = Post(imageEndpoint: sampleImageIdentifier, caption: "Nice shot!", comments: [comment1, comment2], likes: [like1, like2, like3])
        let post2 = Post(imageEndpoint: sampleImageIdentifier, caption: "Great lookin' kids!")
        let post3 = Post(imageEndpoint: sampleImageIdentifier, caption: "Love the way she looks when she smiles like that.")
        
        return [post1, post2, post3]
    }
    
    
}