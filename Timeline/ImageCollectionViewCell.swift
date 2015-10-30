//
//  ImageCollectionViewCell.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/30/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func updateWithImageIdentifier(identifier: String) {
        
        ImageController.imageForIdentifier(identifier) { (image) -> Void in

            self.imageView.image = image
        }
    }

}
