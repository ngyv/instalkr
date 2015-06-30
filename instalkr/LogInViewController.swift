//
//  LogInViewController.swift
//  instalkr
//
//  Created by Yvonne Ng on 6/27/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class LogInViewController : UIViewController, WKNavigationDelegate
{
    
    private var logInWebView : WKWebView?
    
    let given_redirect : String = "http://sassycodes.tumblr.com"
    
    var access_token : String?
    
    override func loadView()
    {
        self.logInWebView = WKWebView()
        
        logInWebView?.navigationDelegate = self
        
        view = logInWebView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

    /**
        
        Step One: Direct your user to our authorization URL
        
        https://instagram.com/oauth/authorize/?client_id=CLIENT-ID&redirect_uri=REDIRECT-URI&response_type=token
        
    */
        
        //the check has been done on the Welcome page
        self.loadInstagramLogIn()
        
    }
    
    func loadInstagramLogIn()
    {
        if let authenticateURL = NSURL(string: Instagram_API.getAuthenticateURL())
        {
            let req = NSURLRequest(URL: authenticateURL)
            
            logInWebView?.loadRequest(req)
        }
        
    }
    
    func goToSearch()
    {
        self.performSegueWithIdentifier("logInToSearch", sender: self)
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!)
    {
        
    /**
        
        Step Two: Receive the access_token via the URL fragment
        
        Once the user has authenticated and then authorized your application, 
        Instagram redirects them to your redirect_uri with the access_token in the url fragment
        
    */

        
        if webView.URL?.absoluteString?.lowercaseString.rangeOfString(self.given_redirect) != nil
        {
            var redirect = webView.URL!.absoluteString!
            
            NSLog(redirect)
            var dump : String = "/#access_token="
            
            self.access_token = redirect.substringFromIndex(advance(redirect.startIndex, count(self.given_redirect) + count(dump)))
            
            
            
//-->   Save user preferences
            
            let userPref = NSUserDefaults.standardUserDefaults()
            userPref.setObject(self.access_token, forKey: "access_token")
            

            
            self.goToSearch()
            
            
           
        }
    }
    
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError)
    {
        
        var mcShrugs : UIImage = UIImage.init(named: "Shrugs")!
        
        view.addSubview(UIImageView.init(image: mcShrugs))

        var alertUser : UIAlertController = UIAlertController.init(title: "Oops!", message: "Something appears to have gone wrong. Please try again." , preferredStyle: UIAlertControllerStyle.Alert)
        
        var actionUser : UIAlertAction = UIAlertAction.init(title:"OK", style: UIAlertActionStyle.Default,
            handler: { (actionUser: UIAlertAction!) -> Void in
            
                view.subviews.map({ $0.removeFromSuperview() })
                
        })
        
        alertUser.addAction(actionUser)
        self.presentViewController(alertUser, animated: true, completion: nil)
        
        
    }
    
}

