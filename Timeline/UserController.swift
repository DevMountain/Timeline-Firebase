//
//  UserController.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/24/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class UserController {
    
    private let UserKey = "user"
    
    static let sharedController = UserController()

    var currentUser: User! {
        get {
            
            guard let uid = FirebaseController.base.authData?.uid,
                let userDictionary = NSUserDefaults.standardUserDefaults().valueForKey(UserKey) as? [String: AnyObject] else {
                    
                    return nil
            }
            
            return User(json: userDictionary, identifier: uid)
        }
        
        set {
            
            if let newValue = newValue {
                NSUserDefaults.standardUserDefaults().setValue(newValue.jsonValue, forKey: UserKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            } else {
                NSUserDefaults.standardUserDefaults().removeObjectForKey(UserKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        
        FirebaseController.dataAtEndpoint("users/\(identifier)") { (data) -> Void in
            
            if let json = data as? [String: AnyObject] {
                let user = User(json: json, identifier: identifier)
                completion(user: user)
            } else {
                completion(user: nil)
            }
        }
    }
    
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        
        FirebaseController.dataAtEndpoint("users") { (data) -> Void in
            
            if let json = data as? [String: AnyObject] {
                
                let users = json.flatMap({User(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
                
                completion(users: users)
                
            }
        }
    }
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        
        FirebaseController.base.childByAppendingPath("/users/\(sharedController.currentUser.identifier!)/follows/\(user.identifier!)").setValue(true)
        
        completion(success: true)
    }
    
    static func unfollowUser(user: User, completion: (success: Bool) -> Void) {
        
        FirebaseController.base.childByAppendingPath("/users/\(sharedController.currentUser.identifier!)/follows/\(user.identifier!)").removeValue()
        
        completion(success: true)
    }
    
    static func userFollowsUser(user: User, followsUser: User, completion: (follows: Bool) -> Void ) {
        
        FirebaseController.dataAtEndpoint("/users/\(user.identifier!)/follows/\(followsUser.identifier!)") { (data) -> Void in
            
            if let data = data {
                completion(follows: true)
            } else {
                completion(follows: false)
            }
        }
    }
    
    static func followedByUser(user: User, completion: (followed: [User]?) -> Void) {
        
        FirebaseController.dataAtEndpoint("/users/\(user.identifier!)/follows/") { (data) -> Void in
            
            if let json = data as? [String: AnyObject] {
                
                var users: [User] = []
                
                
                for userJson in json {
                    
                    userForIdentifier(userJson.0, completion: { (user) -> Void in
                        
                        if let user = user {
                            users.append(user)
                            completion(followed: users)
                        }
                    })
                }
            }
        }
    }
    
    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        
        FirebaseController.base.authUser(email, password: password) { (error, response) -> Void in
            
            if error != nil {
                
                print("Unsuccessful login attempt.")
            } else {
                print("User ID: \(response.uid) authenticated successfully.")
                
                UserController.userForIdentifier(response.uid, completion: { (user) -> Void in
                    
                    if let user = user {
                        
                        sharedController.currentUser = user
                    }
                    
                    completion(success: true, user: user)
                })
            }
        }
    }
    
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        
        FirebaseController.base.createUser(email, password: password) { (error, response) -> Void in
            
            if let uid = response["uid"] as? String {
                var user = User(username: username, uid: uid, bio: bio, url: url)
                user.save()
                
                authenticateUser(email, password: password, completion: { (success, user) -> Void in
                    completion(success: success, user: user)
                })
            }
        }
        
        completion(success: true, user: mockUsers().first)
    }
    
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        
        var updatedUser = User(username: user.username, uid: user.identifier!, bio: bio, url: url)
        updatedUser.save()
        
        UserController.userForIdentifier(user.identifier!) { (user) -> Void in
            
            if let user = user {
                
                sharedController.currentUser = user
            }
            
            completion(success: true, user: user)
        }
    }
    
    static func logoutCurrentUser() {
        
        FirebaseController.base.unauth()
        
        sharedController.currentUser = nil
    }
    
    static func mockUsers() -> [User] {
        
        let user1 = User(username: "hansolo", uid: "1234")
        let user2 = User(username: "ob1kenob", uid: "1235")
        let user3 = User(username: "3po", uid: "1236")
        
        return [user1, user2, user3]
    }
    
}