//
//  LoginViewController.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/20/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: AbstractViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
    }
    
    
}

// MARK: FBSDKLoginButton Delegate

extension LoginViewController:FBSDKLoginButtonDelegate {
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        print("error - \(error)")
        print("result - \(result)")
        if error == nil {
//            pushViewControllerWithIdentifier("GenresViewController")
            self.performSegueWithIdentifier("goToTabBarController", sender: nil)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    
    }
}
