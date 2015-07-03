//
//  SearchViewController.swift
//  instalkr
//
//  Created by Yvonne Ng on 6/27/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation
import UIKit

class GraphViewController : UIViewController
{
    
    @IBOutlet weak var relationshipScrollView: UIScrollView!
    
    var mainUserNode : VMUser?
    var theGraph : Graph
    
    
    required init(coder aDecoder: NSCoder)
    {
        
        //** As of now, assume that the user has already logged in
        
        var userPref = NSUserDefaults.standardUserDefaults()
        
        var mainUser : UserNode = UserNode(me: Model_User.createMUser(userPref.objectForKey("user")!))
        
        self.theGraph = Graph(theMainUser: mainUser)
        
        
        super.init(coder: aDecoder)
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        self.createUserView( true )
        self.reloadUserView(self.theGraph.userInFocus.myself, userView: mainUserNode!)
        
    }
    
    func createUserView ( main : Bool )
    {
        var frame : CGRect
        var x : CGFloat
        var y : CGFloat
        var widthHeight : CGFloat
        
        
        
        if ( main )
        {
            widthHeight = 200
            x = (relationshipScrollView.bounds.width - widthHeight)/2
            y = (relationshipScrollView.bounds.height - widthHeight)/2
            
        }
        else
        {
            widthHeight = 160
            x = (relationshipScrollView.bounds.width - widthHeight)/2
            y  = (relationshipScrollView.bounds.height - widthHeight)/2
            
        }
        frame = CGRectMake(x, y, widthHeight, widthHeight)
        mainUserNode = VMUser(frame: frame)
        
        x = frame.width / 20
        var imgWidth : CGFloat = frame.width - (x * 2)
        
        mainUserNode!.imageView = UIImageView(frame: CGRectMake( x, 0, imgWidth, imgWidth))
        mainUserNode!.usernameLabel = UILabel(frame: CGRectMake( x, imgWidth, imgWidth, x * 2))
        
        
        
        mainUserNode!.addSubview(mainUserNode!.imageView!)
        mainUserNode!.addSubview(mainUserNode!.usernameLabel!)
        
        self.relationshipScrollView.addSubview(mainUserNode!)
        
        
        // to make the UIImageView circular
        mainUserNode!.imageView!.layer.cornerRadius = mainUserNode!.imageView!.frame.size.height/2
        mainUserNode!.imageView!.layer.masksToBounds = true
        mainUserNode!.imageView!.layer.borderColor = UIColor.lightGrayColor().CGColor
        mainUserNode!.imageView!.layer.borderWidth = 0.7
        
        mainUserNode!.usernameLabel!.font = UIFont(name: "Helvetica Neue", size: 16.0)
        mainUserNode!.usernameLabel!.textAlignment = NSTextAlignment.Center
        mainUserNode!.usernameLabel!.textColor = UIColor.grayColor()
        
        
        // Add constraints  -->   item1.attribute1 = multiplier × item2.attribute2 + constant
        
        //  Set width & height of View
        
        
        mainUserNode!.addConstraint(NSLayoutConstraint(item: mainUserNode!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 200))
        
        mainUserNode!.addConstraint(NSLayoutConstraint(item: mainUserNode!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 200))
        
        //  Set center of margin with regards to the superview
        
        relationshipScrollView.addConstraint(NSLayoutConstraint(item: mainUserNode!, attribute: NSLayoutAttribute.CenterXWithinMargins, relatedBy: NSLayoutRelation.Equal, toItem: relationshipScrollView, attribute: NSLayoutAttribute.CenterXWithinMargins, multiplier: 1.0, constant: 0))
        
        relationshipScrollView.addConstraint(NSLayoutConstraint(item: mainUserNode!, attribute: NSLayoutAttribute.CenterYWithinMargins, relatedBy: NSLayoutRelation.Equal, toItem: relationshipScrollView, attribute: NSLayoutAttribute.CenterYWithinMargins, multiplier: 1.0, constant: 0))
        
        
        // --> This is the damn piece I was missing all along! -.-
        mainUserNode!.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
    }
    
    
    func reloadUserView( user : Model_User, userView : VMUser )
    {
        var theSession = NSURLSession.sharedSession()
        
        
        
        if( theGraph.userInFocus.myself.id == user.id )
        {
            
        }
        else
        {
            
        }
        
        
        
        
        
        
        
        
        
        // Get Image
        
        if let url = NSURL( string: user.profile_picture )
        {
            var task : NSURLSessionDataTask =  theSession.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) -> Void in
                dispatch_async(dispatch_get_main_queue(),{
                    self.mainUserNode!.imageView!.image = UIImage(data: data)!
                    
                    UIView.animateWithDuration(1.0, delay: 0.8, options: UIViewAnimationOptions.CurveLinear, animations: {   () -> Void in
                        
                        userView.usernameLabel!.text = user.username
                        userView.usernameLabel!.alpha = 1.0
                        
                        }
                        , completion: {   (done) -> Void in
                            
                            UIView.animateWithDuration(0.5, animations: {   () -> Void in
                                
                                userView.usernameLabel!.font = UIFont(name: "Helvetica Neue Light", size: 15.0)
                                
                            })
                    })
                    
                    return
                    
                })
                
                
                
            })
            
            task.resume()
        }
        
        
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