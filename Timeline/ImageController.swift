//
//  ImageController.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/26/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class ImageController {
    
    static func uploadImage(image: UIImage, completion: (identifier: String?) -> Void) {
        
        completion(identifier: "-K1l4125TYvKMc7rcp5e")
    }
    
    static func imageForIdentifier(identifier: String, completion: (image: UIImage?) -> Void) {
        
        completion(image: UIImage(named: "MockPhoto"))
    }
}