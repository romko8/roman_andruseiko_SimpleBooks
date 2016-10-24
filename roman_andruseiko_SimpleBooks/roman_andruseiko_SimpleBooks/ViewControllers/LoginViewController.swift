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
        
        buildUI()
        
        checkForExistingUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        super.viewDidDisappear(animated)
    }
    
    func buildUI() {
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        
        self.view.addSubview(loginView)
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: loginView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: loginView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.5, constant: 0))
        
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
    }
    
    func checkForExistingUser() {
        if CoreDataManager.sharedInstance.isUserLoggedIn() {
            makeLogIn()
        }
    }
    
    func makeLogIn() {
        self.performSegue(withIdentifier: "tabBarControllerSegue", sender: nil)
    }
    
}

// MARK: FBSDKLoginButton Delegate

extension LoginViewController:FBSDKLoginButtonDelegate {
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {

        if error == nil {
            let facebookToken = result.token.tokenString
            FBSDKGraphRequest.init(graphPath: "me", parameters: nil, httpMethod: "GET").start(completionHandler: { (connection, result, error) in
                if error == nil {
                    let userDetails = result as? [String : String]
                    let userId = userDetails?["id"] ?? ""
                    let userName = userDetails?["name"] ?? ""
                    _ = CoreDataManager.sharedInstance.createUser(id: userId, name: userName, token: facebookToken!)
                    self.makeLogIn()
                } else {
                    self.showErrorMessage()
                }
            })
        } else {
            self.showErrorMessage()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    
    }
}
