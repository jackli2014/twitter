//
//  LoginViewController.swift
//  twitter
//
//  Created by Shengjun Li on 2/22/15.
//  Copyright (c) 2015 Shengjun Li. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = ""
let userDidLoginNotification = ""
let userDidLogoutNotification = ""

class User: NSObject {

    var name: String
    var screenname: String
    var profileImageUrl: NSURL
    var tagline: String
    var dictionary: NSDictionary

    init(dictionary: NSDictionary) {
        self.dictionary = dictionary

        self.name = dictionary["name"] as String
        self.screenname = dictionary["screen_name"] as String
        self.profileImageUrl = NSURL(string: (dictionary["profile_image_url"] as String).stringByReplacingOccurrencesOfString("_normal", withString: "_bigger", options: nil, range: nil))!
        self.tagline = dictionary["description"] as String
    }

    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()

        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }

    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user

            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

}
