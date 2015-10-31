//
//  AddPhotoTableViewController.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/24/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class AddPhotoTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var image: UIImage?
    var caption: String?
    
    @IBOutlet weak var photoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func addPhotoTapped(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let photoChoiceAlert = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .ActionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            photoChoiceAlert.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: { (_) -> Void in
                imagePicker.sourceType = .PhotoLibrary
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            
            photoChoiceAlert.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (_) -> Void in
                imagePicker.sourceType = .Camera
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
            
        }
        
        photoChoiceAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(photoChoiceAlert, animated: true, completion: nil)
    }
    
    @IBAction func submitButtonTapped(sender: AnyObject) {
        
        self.view.window?.endEditing(true)
        if let image = image  {
            
            //POST IMAGE
            
            PostController.addPost(image, caption: self.caption, completion: { (post) -> Void in
                if post != nil {
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    let failedAlert = UIAlertController(title: "Failed!", message: "Image failed to post. Please try again.", preferredStyle: .Alert)
                    failedAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(failedAlert, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - Image Picker Controller Delegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        photoButton.setBackgroundImage(image, forState: .Normal)
        photoButton.setTitle(nil, forState: .Normal)
    }
}

extension AddPhotoTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        caption = textField.text
        textField.resignFirstResponder()
        return true
    }
}