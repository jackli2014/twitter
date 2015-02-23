//
//  LoginViewController.swift
//  twitter
//
//  Created by Shengjun Li on 2/22/15.
//  Copyright (c) 2015 Shengjun Li. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                // Handle login error
            }
        }

    }
}