//
//  ViewController.swift
//  instalkr
//
//  Created by Yvonne on 26/6/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import UIKit

class WelcomeViewController : UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var continueAsGuestButton: UIButton!
    
    @IBOutlet weak var incognitoWelcomeImage: UIImageView!

    @IBOutlet weak var welcomeLabel: UILabel!
    

    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.welcomeLabel.hidden = true
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        //-->  Check for user preference if they're authenticated and have authorized your application
        let userPref = NSUserDefaults.standardUserDefaults()
        
        if let access_token: AnyObject = userPref.objectForKey("access_token")
        {
            self.welcomeLabel.hidden = false
            
            self.logInButton.hidden = true
            self.continueAsGuestButton.hidden = true
            
            self.bounceImageAndGoSearch()
            
        }

    }
    
    func bounceImageAndGoSearch()
    {
        var one : UIImage = UIImage.init(named: "incognito 1")!
        var two : UIImage = UIImage.init(named: "incognito 2")!
        var three : UIImage = UIImage.init(named: "incognito 3")!
        
        var viewOne : UIImageView = UIImageView.init(image: one)
        var viewTwo : UIImageView = UIImageView.init(image: two)
        var viewThree : UIImageView = UIImageView.init(image: three)
        
        var transitionViews : [UIImageView] = [viewOne, viewTwo, viewThree]
    
        for theView in transitionViews
        {
            theView.frame = self.incognitoWelcomeImage.frame
        }
        
        UIView.transitionFromView(self.incognitoWelcomeImage, toView: viewOne, duration: 2.5, options: UIViewAnimationOptions.TransitionCrossDissolve, completion: { (finished : Bool) -> Void in
            
            UIView.transitionFromView(viewOne, toView: viewTwo, duration: 1.2, options: UIViewAnimationOptions.TransitionCrossDissolve, completion: { (finished : Bool) -> Void in
                
                
                UIView.transitionFromView(viewTwo, toView: viewThree, duration: 1.1, options: UIViewAnimationOptions.TransitionCrossDissolve, completion: { (finished : Bool) -> Void in
                    
                        self.performSegueWithIdentifier("welcomeToSearch", sender: self)
                    
                })
                
            })
            
        })
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }

}

