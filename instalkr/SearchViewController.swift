//
//  SearchViewController.swift
//  instalkr
//
//  Created by Yvonne Ng on 6/27/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController : UIViewController
{

    @IBOutlet weak var relationshipScrollView: UIScrollView!

    var access_token : String?
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        

        
        
    }
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
    
        //------> get user logged in basic info & store it
        
        
        var userPref : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        self.access_token =  (userPref.objectForKey("access_token") as? String)!
        
        var theSession : NSURLSession = NSURLSession.sharedSession()
        
        var theURL     : NSURL        = NSURL(string: Instagram_API.getOWNBasicUserInfo(self.access_token!))!
        
        var theRequest : NSURLRequest = NSURLRequest(URL: theURL)
        
        theSession.dataTaskWithRequest(theRequest, completionHandler: {
            
            (data, response, error) -> Void in
            
            let jsonData: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers , error: nil)!
            
            //var userLoggedIn : Model_User = Model_User.createMUser(jsonData.objectForKey("data")!)
            
            //NSLog("\(userLoggedIn.id)")
            
            userPref.setObject(jsonData.objectForKey("data")!, forKey: "user")
            
        }).resume()
    }
}


/*----------

→  Show {relationship graph}

   Show main user profile picture in the middle of the screen
   the top 8 people he has tagged in his pictures should be displayed on a ring

    (a) if he doesn’t have any pictures, then show 8 people he follows that have the most pictures
    (b) if he is not following anyone, then show 8 people that have the most pictures follows him
        if he has insufficient contacts (< 8), then combine the pool of people (a) &

*/