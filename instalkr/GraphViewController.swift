//
//  SearchViewController.swift
//  instalkr
//
//  Created by Yvonne Ng on 6/27/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation
import UIKit

class GraphViewController : UIViewController, UISearchBarDelegate
{
    
    @IBOutlet weak var relationshipScrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var searchBarView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var mainUserNode : VMUser?
    var theGraph : Graph
    var theAlgorithm : Algorithm?
    
    
    let goToSearch : String = "graphToSearch"
    
    required init(coder aDecoder: NSCoder)
    {
        
        //** As of now, assume that the user has already logged in
        
        var userPref = NSUserDefaults.standardUserDefaults()
        
        var mainUser : UserNode = UserNode(me: Model_User.createMUser(userPref.objectForKey(userPrefKeys_user)!))
            
        self.theGraph = Graph(theMainUser: mainUser)
            
  //      self.theAlgorithm = Algorithm_PopularContacts(someGraph: theGraph)

        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad()
    {
 
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        

        
/*
        if let getTop = theAlgorithm.getUserTopContacts(theGraph.userInFocus)
        {
            theGraph.userInFocus.myTopContacts = getTop
            for eachUser in theGraph.userInFocus.myTopContacts
            {
                theGraph.listOfUserNodes.append(UserNode(me: eachUser))
            }
            var topContacts : [ Model_User ] = theAlgorithm.theGraph.userInFocus.myTopContacts
        }

*/
        self.createUserView( true )
        self.reloadUserView(self.theGraph.userInFocus.myself, userView: mainUserNode!)
        
        self.getContacts(self.theGraph.userInFocus.myself.id)
        
    }

    override func viewWillDisappear(animated: Bool)
    {
        //-- development purposes
        var userPref = NSUserDefaults.standardUserDefaults()
        
        
        //userPref.setObject(theGraph.userInFocus.myself.id, forKey: "userInFocus")
        //var uids : [ String ] = theGraph.userInFocus.myTopContacts.map{ return $0.id }
        //userPref.setObject( uids, forKey: "topUsers")
        
        //--
        
        super.viewWillDisappear(animated)
    
    }
    
    func createUserView ( main : Bool )
    {
        
        var widthHeight : CGFloat = main ? 200 : 160
  
        var x : CGFloat  = (relationshipScrollView.bounds.width - widthHeight)/2
        var y : CGFloat  = (relationshipScrollView.bounds.height - widthHeight)/2
        
        var frame : CGRect = CGRectMake(x, y, widthHeight, widthHeight)
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

    func getContacts( user_id : String )
    {
        self.getFollows(user_id)
        self.getFollowedBys(user_id)
        
    }
    
    
    func getFollows ( user_id : String )
    {
        
        
        var theSession = NSURLSession.sharedSession()
        var access_token : String = NSUserDefaults.standardUserDefaults().objectForKey(userPrefKeys_accessToken) as! String
        if let url : NSURL = NSURL( string: Instagram_API.getRelationshipUserFollows(access_token, user_id: user_id) )
        {
            var req : NSURLRequest = NSURLRequest(URL: url)
            theSession.dataTaskWithRequest(req, completionHandler:  {
                
                ( data, response, error ) -> Void in
                
                let jsonData: AnyObject = NSJSONSerialization.JSONObjectWithData( data, options: NSJSONReadingOptions.MutableContainers, error: nil )!
                
                var array : NSMutableArray = jsonData.objectForKey("data")! as! NSMutableArray
                
                for eachUser in array
                {
                    var u : Model_User = Model_User(id: eachUser.objectForKey("id") as! String,
                        username: eachUser.objectForKey("username") as! String,
                        full_name: eachUser.objectForKey("full_name") as! String,
                        profile_picture: eachUser.objectForKey("profile_picture") as! String)
                    
                    
                    self.theGraph.userInFocus.myTopContacts[contactsFollows]?.append(u)
                }
                
                NSLog("Follows : \n\n\(self.theGraph.userInFocus.myTopContacts.count)\n")
            }).resume()
            
        }
        
        
    }
    
    func getFollowedBys ( user_id : String )
    {
        
        var theSession = NSURLSession.sharedSession()
        var access_token : String = NSUserDefaults.standardUserDefaults().objectForKey(userPrefKeys_accessToken) as! String
        
        if let url : NSURL = NSURL ( string: Instagram_API.getRelationshipUserFollowedBy(access_token, user_id: user_id) )
        {
            theSession.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) -> Void in
                
                let jsonData : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)!
                
                var array : NSMutableArray = jsonData.objectForKey("data")! as! NSMutableArray
                
                for eachUser in array
                {
                    var u : Model_User = Model_User(id: eachUser.objectForKey("id") as! String,
                        username: eachUser.objectForKey("username") as! String,
                        full_name: eachUser.objectForKey("full_name") as! String,
                        profile_picture: eachUser.objectForKey("profile_picture") as! String)
                    
                    
                    self.theGraph.userInFocus.myTopContacts[contactsFollowedBy]?.append( u )
                }
                
                NSLog("Followed By : \n\n\(self.theGraph.userInFocus.myTopContacts.count)\n")
            }).resume()
            
        }
        
        
    }

    // -- Search Bar methods
    func searchBar( searchBar: UISearchBar, textDidChange searchText: String)
    {
        
    }

    func searchBarSearchButtonClicked( searchBar: UISearchBar)
    {
        self.performSegueWithIdentifier( goToSearch , sender: self)
    }

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool
    {
        searchBar.alpha = 0.8

        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        
        searchBar.alpha = 0.15
        
        return true
    }

    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == goToSearch )
        {
            var controller : UIViewController = segue.destinationViewController as! SearchViewController
            
            
        }
    }
    
    
    
}