//
//  LoginViewController.swift
//  twitter
//
//  Created by Shengjun Li on 2/22/15.
//  Copyright (c) 2015 Shengjun Li. All rights reserved.
//

import UIKit

class Status: NSObject {

    var user: User
    var text: String
    var createdAt: NSDate
    var numberOfRetweets: Int
    var numberOfFavorites: Int

    init(dictionary: NSDictionary) {
        self.user = User(dictionary: dictionary["user"] as NSDictionary)
        self.text = dictionary["text"] as String

        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        self.createdAt = formatter.dateFromString(dictionary["created_at"] as String)!

        self.numberOfRetweets = dictionary["retweet_count"] as Int
        self.numberOfFavorites = dictionary["favorite_count"] as Int
    }

    class func statusesWithArray(array: [NSDictionary]) -> [Status] {
        var statuses = [Status]()
        for dictionary in array {
            statuses.append(Status(dictionary: dictionary))
        }
        return statuses
    }
}
