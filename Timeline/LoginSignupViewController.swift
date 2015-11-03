//
//  LoginSignupViewController.swift
//  Timeline
//
//  Created by Caleb Hicks on 10/29/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class LoginSignupViewController: UIViewController {
    
    enum ViewMode {
        case Login
        case Signup
        case Edit
    }
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var bioField: UITextField!
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    var mode: ViewMode = .Signup

    var user: User?
    
    var fieldsAreValid: Bool {
        
        switch mode {
            
        case .Login:
            
            return !(emailField.text!.isEmpty || passwordField.text!.isEmpty)
            
        case .Signup:
            
            return !(usernameField.text!.isEmpty || emailField.text!.isEmpty || passwordField.text!.isEmpty)
        
        case .Edit:
            
            return !(usernameField.text!.isEmpty)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViewForMode(mode)
    }
    
    func updateViewForMode(mode: ViewMode) {
        
        switch mode {
            
        case .Signup:
            
            actionButton.setTitle("Sign Up", forState: .Normal)
            
        case .Login:
            
            actionButton.setTitle("Log In", forState: .Normal)
            
            usernameField.removeFromSuperview()
            bioField.removeFromSuperview()
            urlField.removeFromSuperview()
        
        case .Edit:
        
            actionButton.setTitle("Update", forState: .Normal)
            
            emailField.removeFromSuperview()
            passwordField.removeFromSuperview()

            if let user = self.user {
                
                usernameField.text = user.username
                bioField.text = user.bio
                urlField.text = user.url
                
            }
            
        }
    }

    @IBAction func actionButtonTapped(sender: AnyObject) {
        
        if fieldsAreValid {
            switch mode {
                
            case .Signup:
                
                UserController.createUser(emailField.text!, username: usernameField.text!, password: passwordField.text!, bio: bioField.text, url: urlField.text, completion: { (success, user) -> Void in
                    if success {
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable to Create User", text: "Please check your information and try again.")
                    }
                })
                
            case .Login:
                
                UserController.authenticateUser(emailField.text!, password: passwordField.text!, completion: { (success, user) -> Void in
                    
                    if success {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable to Log In", text: "Please check your information and try again.")
                    }
                })
                
            case .Edit:
                
                UserController.updateUser(self.user!, username: self.usernameField.text!, bio: self.bioField.text, url: self.urlField.text, completion: { (success, user) -> Void in
                    
                    if success {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable to Update User", text: "Please check your information and try again.")
                    }
                })
                
            }
        } else {
            
            self.presentValidationAlertWithTitle("Missing Information", text: "Please check your information and try again.")
        }
        
    }
    
    func updateWithUser(user: User) {
        
        self.user = user
        mode = .Edit
        
        updateViewForMode(mode)
    }
    
    func presentValidationAlertWithTitle(title: String, text: String) {
        
        let alert = UIAlertController(title: title, message: text, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
}
