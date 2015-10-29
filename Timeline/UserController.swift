//
//  UserController.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/24/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class UserController {
    
    static func currentUser() -> User! {
        return mockUsers().first
    }
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        
        completion(user: mockUsers().first)
    }
    
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        
        completion(users: mockUsers())
    }
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        
        completion(success: true)
    }
    
    static func followedByUser(user: User, completion: (followed: [User]?) -> Void) {
        
        completion(followed: [mockUsers().first!])
    }
    
    static func followersForUser(user: User, completion: (followers: [User]?) -> Void) {
        
        completion(followers: mockUsers())
    }
    
    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        
        completion(success: true, user: mockUsers().first)
    }
    
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        
        completion(success: true, user: mockUsers().first)
    }
    
    static func mockUsers() -> [User] {
        
        let user1 = User(username: "hansolo")
        let user2 = User(username: "ob1kenob")
        let user3 = User(username: "3po")
        
        return [user1, user2, user3]
    }
    
}