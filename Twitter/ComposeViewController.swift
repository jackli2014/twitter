//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Shengjun Li on 2/23/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    
    
    @IBOutlet weak var nameLbl: UILabel!
    
    
    @IBOutlet weak var screenLbl: UILabel!
    
    

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImg.setImageWithURL(User.currentUser?.profileImageUrl)
       
        self.nameLbl.text = User.currentUser?.name
        self.screenLbl.text = "@\(User.currentUser!.screenname)"
    }
    
    
    @IBAction func onCancel(sender: UIBarButtonItem) {
          self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func onTweet(sender: AnyObject) {
        
        let status = self.textView.text
        if (countElements(status) == 0) {
            return
        }
        
        var params: NSDictionary = [
            "status": status
        ]
        
        TwitterClient.sharedInstance.postStatusUpdateWithParams(params, completion: { (status, error) -> () in
            if error != nil {
                NSLog("error posting status: \(error)")
                return
            }
            NSNotificationCenter.defaultCenter().postNotificationName(TwitterEvents.StatusPosted, object: status)
            self.dismissViewControllerAnimated(true, completion: nil)
        })

        
    }
    
}
