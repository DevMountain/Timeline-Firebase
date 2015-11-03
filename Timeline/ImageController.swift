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
        
        if let base64Image = image.base64String {
            let base = FirebaseController.base.childByAppendingPath("images").childByAutoId()
            base.setValue(base64Image)
            
            completion(identifier: base.key)
        } else {
            completion(identifier: nil)
        }
    }
    
    static func imageForIdentifier(identifier: String, completion: (image: UIImage?) -> Void) {
        
        FirebaseController.dataAtEndpoint("images/\(identifier)") { (data) -> Void in
            
            if let data = data as? String {
                let image = UIImage(base64: data)
                completion(image: image)
            }
        }
    }
}

extension UIImage {
    
    var base64String: String? {
        
        guard let data = UIImageJPEGRepresentation(self, 0.8) else {
            
            return nil
        }
        
        return data.base64EncodedStringWithOptions(.EncodingEndLineWithCarriageReturn)
    }
    
    convenience init?(base64: String) {
        
        if let imageData = NSData(base64EncodedString: base64, options: .IgnoreUnknownCharacters) {
            self.init(data: imageData)
        } else {
            return nil
        }
    }
}