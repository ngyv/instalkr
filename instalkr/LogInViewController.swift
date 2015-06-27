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
        
        
        if let authenticateURL = NSURL(string: "https://instagram.com/oauth/authorize/?client_id=89dc0b5019ed496da3ce54763e3b5254&redirect_uri=http://sassycodes.tumblr.com&response_type=token")
        {
            let req = NSURLRequest(URL: authenticateURL)
            
            logInWebView?.loadRequest(req)
        }
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
            
            self.access_token = redirect.substringFromIndex(advance(redirect.startIndex, count(self.given_redirect)))
            
            //self.performSegueWithIdentifier("logInToSearch", sender: self)
            
        }
    }
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if(segue.identifier == "logInToSearch")
        {
            (segue.destinationViewController as! SearchViewController).access_token = self.access_token!
        }
    }*/
}

