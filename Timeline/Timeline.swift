//
//  Timeline.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/24/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class Timeline {
    
    static let sharedTimeline = Timeline()
    
    var posts: [Post] {
        
        return PostController.mockPosts()
    }
}