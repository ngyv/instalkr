//
//  SearchViewController.swift
//  instalkr
//
//  Created by Yvonne Ng on 6/27/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation
import UIKit

class GraphViewController : UIViewController, UISearchBarDelegate, UIGestureRecognizerDelegate
{
    
    @IBOutlet weak var relationshipScrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var searchBarView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var mainUserNode: VMUser!
    @IBOutlet weak var followsMiddleNode: VMUser!
    @IBOutlet weak var followsLeftNode: VMUser!
    @IBOutlet weak var followsRightNode: VMUser!
    @IBOutlet weak var followedByMiddleNode: VMUser!
    @IBOutlet weak var followedByLeftNode: VMUser!
    @IBOutlet weak var followedByRightNode: VMUser!
    
    
    var theGraph : Graph
    var theAlgorithm : Algorithm?
    
    var searchedUser : Model_User?
    
    var lastFollowsIndex : Int = -1
    var lastFollowedByIndex : Int = -1
    
    var swipeUp : [ UISwipeGestureRecognizer ] = [ UISwipeGestureRecognizer ]()
    var doubleTap : [ UITapGestureRecognizer ] = [ UITapGestureRecognizer ]()
    var longPress : [UILongPressGestureRecognizer ] = [ UILongPressGestureRecognizer ]()
    
    var userViewPressed : VMUser?
    var panGR : UIPanGestureRecognizer?
    
    var results : [ Model_User ]?
    
    
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
        
        self.refreshViews()
        
        
        //self.loadUserViews()
        
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
    
    func refreshViews()
    {
        if let haveSearchedUser = searchedUser
        {
            self.theGraph = Graph(theMainUser: UserNode(me: haveSearchedUser))
        }
        
        self.searchBar.delegate = self
        
        self.initGestureRecognizers()
        
        self.linkUserViews()
        
        self.getContacts(self.theGraph.userInFocus.myself.id)
        
        self.reloadUserView(self.theGraph.userInFocus.myself, userView: mainUserNode)
        
    }
    
    
    func initGestureRecognizers()
    {
        for var i = 0; i < 6; i++
        {
            // Double Tap
            var newTapGestureRecognizer  = UITapGestureRecognizer()
            newTapGestureRecognizer.numberOfTapsRequired = 2
            newTapGestureRecognizer.addTarget(self, action: "tapAction:")
            
            self.doubleTap.append( newTapGestureRecognizer )
            
            
            
            // Long Press
            var newLongPressGestureRecognizer = UILongPressGestureRecognizer()
            newLongPressGestureRecognizer.addTarget(self, action: "longPressAction:")
            
            self.longPress.append( newLongPressGestureRecognizer )
            
            
        }
    }
    
    // { 0 : follows , 1 : followedBy , 2 : main }
    func linkUserViews()
    {
        var allNodes : [ VMUser ] = [ mainUserNode, followsMiddleNode, followsLeftNode, followsRightNode,
                                     followedByMiddleNode, followedByLeftNode, followedByRightNode ]
        var tagNums : [ Int ] = [ 101, 1011,   102, 1022,   103, 1033,   104, 1044,   105, 1055,   106, 1066,   107, 1077 ]
        
        for var i = 0; i < allNodes.count; i++
        {
            allNodes[i].imageView = allNodes[i].viewWithTag( tagNums[i * 2] ) as? VMImg
            allNodes[i].usernameLabel = allNodes[i].viewWithTag( tagNums[(i * 2 + 1)] ) as? VMLabel
        
            allNodes[i].setStyle()
            
            if(i != 0)
            {
                allNodes[i].imageView?.addGestureRecognizer( doubleTap[i-1] )
                
                allNodes[i].addGestureRecognizer( longPress[i-1] )
            }
        }
        
    }
    
    
    func loadUserViews( followsONEfollowedTWO : Int )
    {
        
        var nodes : [ VMUser ]?
        var models : [ Model_User ]?
        if(followsONEfollowedTWO == 1)
        {
            nodes = [ followsMiddleNode, followsLeftNode, followsRightNode ]
            
            models = [  self.theGraph.userInFocus.myTopContacts[contactsFollows]![0],
                        self.theGraph.userInFocus.myTopContacts[contactsFollows]![1],
                        self.theGraph.userInFocus.myTopContacts[contactsFollows]![2] ]
        }
        else if(followsONEfollowedTWO == 2)
        {
            nodes = [ followedByMiddleNode, followedByLeftNode, followedByRightNode ]
            
            models = [ self.theGraph.userInFocus.myTopContacts[contactsFollowedBy]![0],
                       self.theGraph.userInFocus.myTopContacts[contactsFollowedBy]![1],
                       self.theGraph.userInFocus.myTopContacts[contactsFollowedBy]![2] ]
        }
        
        for var i = 0; i < nodes!.count; i++
        {
            self.reloadUserView(models?[i], userView: nodes![i])
        }
        
    }
    
    
    func reloadUserView( user : Model_User?, userView : VMUser )
    {
        if let userAvail = user
        {
            var theSession = NSURLSession.sharedSession()
            userView.userModel = userAvail
        
            // Get Image
        
            if let url = NSURL( string: userAvail.profile_picture )
            {
                var task : NSURLSessionDataTask =  theSession.dataTaskWithURL(url, completionHandler: {
                
                    (data, response, error) -> Void in
                
                    if data != nil
                    {
                    
                        dispatch_async(dispatch_get_main_queue(),{
                        
                            if let getImg = UIImage(data: data)
                            {
                                userView.imageView!.image = getImg
                            }
                            else
                            {
                                userView.imageView!.image =  UIImage(named: "sf_icon")
                            }
                            UIView.animateWithDuration(1.0, delay: 0.8, options: UIViewAnimationOptions.CurveLinear, animations: {   () -> Void in
                        
                                userView.usernameLabel!.text = userAvail.username
                                userView.usernameLabel!.alpha = 1.0
                        
                                }
                                , completion: {   (done) -> Void in
                            
                            
                            })
                    
                            return
                    
                        })
                }
                
                
                })
            
                task.resume()
            }
        }
        else
        {
            userView.imageView!.image =  UIImage(named: "sf_icon")
        }
        
    }
    
    func tapAction( sender : UITapGestureRecognizer )
    {
        var theView : UIImageView = sender.view as! UIImageView
        var ind : Int = (theView.tag % 100) - 2
        var check :  String = ind < 3  ? contactsFollows : contactsFollowedBy
        
        if(self.theGraph.userInFocus.myTopContacts[check]?.count > 3)
        {
            self.replacePic(ind )
        }
        else
        {
            self.getContacts(self.theGraph.userInFocus.myself.id)
        }
    }
    
    func longPressAction( sender : UILongPressGestureRecognizer )
    {
        var theView : VMUser = sender.view as! VMUser
        
        if(theView.selected == 0)
        {
            self.userViewPressed = theView
        
            // Handle the dragging
            self.panGR =  UIPanGestureRecognizer()
            self.panGR!.addTarget( self, action: "panAction:" )
            theView.addGestureRecognizer( self.panGR! )
            
            self.shakeView( theView )
        }

        
        theView.selected++
    }
    
    func panAction( sender : UIPanGestureRecognizer )
    {
        var theView : VMUser = sender.view as! VMUser
        
        var theImg : VMImg = theView.imageView!
        
        var translation : CGPoint = sender.translationInView( theView.superview! )
        
        
        UIView.animateWithDuration(0.25, animations: {
            
            ()-> Void in
        
            theImg.frame = CGRectMake(translation.x, translation.y, theImg.frame.size.width, theImg.frame.size.height)
        })
        
        
        var imgMoving = theImg.convertRect(theImg.bounds, toView: nil)
        var mainUserView = self.mainUserNode.convertRect(self.mainUserNode.bounds, toView: nil)
        
        
        var areaOfIntersection = CGRectIntersection(imgMoving, mainUserView)
        
        if(areaOfIntersection.size.width > theImg.frame.size.width/2 || areaOfIntersection.size.height > theImg.frame.size.height/2)
        {
            //reset for the new user in view
            theView.selected = 0
            
            
            var ind : Int = (theView.tag % 10) - 2
            
            var goBack  = CGRectMake(theView.originalFrame!.origin.x, theView.originalFrame!.origin.y, theView.originalFrame!.size.width, theView.originalFrame!.size.height)
            
            UIView.animateWithDuration(0.1, animations: {
                
                ()-> Void in
                
                theImg.frame = CGRectMake(5, 5, 90, 90)
            })
            
            
            var allContactNodes : [ VMUser ] = [ followsMiddleNode, followsLeftNode, followsRightNode,
                followedByMiddleNode, followedByLeftNode, followedByRightNode ]
            
            self.searchedUser = allContactNodes[ind].userModel
            self.refreshViews()
            
            
        }
    }
    

    func swipeAction( sender: UISwipeGestureRecognizer )
    {
    
        var theView : UIImageView = sender.view as! UIImageView
        var ind : Int = (theView.tag % 100) - 2
        var check :  String = ind < 3  ? contactsFollows : contactsFollowedBy
        
        if(self.theGraph.userInFocus.myTopContacts[check]?.count > 3)
        {
            self.replacePic(ind )
        }
        else
        {
            self.getContacts(self.theGraph.userInFocus.myself.id)
        }
    }
    

    func replacePic( index : Int )
    {
        var allContactNodes : [ VMUser ] = [ followsMiddleNode, followsLeftNode, followsRightNode,
            followedByMiddleNode, followedByLeftNode, followedByRightNode ]
        
        var getContacts : String = index < 3 ? contactsFollows : contactsFollowedBy
        if(self.lastFollowsIndex < self.theGraph.userInFocus.myTopContacts[getContacts]?.count)
        {
            self.lastFollowsIndex++
        }
        else
        {
            self.lastFollowedByIndex = 0
        }
        
        self.reloadUserView(self.theGraph.userInFocus.myTopContacts[getContacts]![self.lastFollowsIndex], userView: allContactNodes[index])
    }
    
    
    func shakeView( theView : UIView )
    {
        
        var animate : CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animate.duration = 0.4
        animate.values = [ -4, 4, -4, 4, -3, 3, -1, 1, 0 ]
        theView.layer.addAnimation(animate, forKey: "shakeView")
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
                
                if (jsonData.objectForKey("meta")!.objectForKey("code") as! Int) == 200
                {

                    var array : NSMutableArray = jsonData.objectForKey("data")! as! NSMutableArray
                
                    for eachUser in array
                    {
                        var u : Model_User = Model_User(id: eachUser.objectForKey("id") as! String,
                            username: eachUser.objectForKey("username") as! String,
                            full_name: eachUser.objectForKey("full_name") as! String,
                            profile_picture: eachUser.objectForKey("profile_picture") as! String)
                    
                    
                        self.theGraph.userInFocus.myTopContacts[contactsFollows]?.append(u)
                    }
                
                    NSLog("Follows : \n\n\(self.theGraph.userInFocus.myTopContacts[contactsFollows]?.count)\n")
                
                    //********
                    self.loadUserViews( 1 )
                    //********
                
                    self.lastFollowsIndex = 2
                }
                

                
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
                
                if (jsonData.objectForKey("meta")!.objectForKey("code") as! Int) == 200
                {
                    var array : NSMutableArray = jsonData.objectForKey("data")! as! NSMutableArray
                
                    for eachUser in array
                    {
                        var u : Model_User = Model_User(id: eachUser.objectForKey("id") as! String,
                            username: eachUser.objectForKey("username") as! String,
                            full_name: eachUser.objectForKey("full_name") as! String,
                            profile_picture: eachUser.objectForKey("profile_picture") as! String)
                    
                    
                        self.theGraph.userInFocus.myTopContacts[contactsFollowedBy]?.append( u )
                    }
                
                    NSLog("Followed By : \n\n\(self.theGraph.userInFocus.myTopContacts[contactsFollowedBy]?.count)\n")
                
                
                    // load contacts' pictures and username when ready
                    self.loadUserViews( 2 )

                
                    self.lastFollowedByIndex = 2
                }
                else
                {
                    
//--> show no picture or sth
                    
                    
                }
                
            }).resume()
            
        }
        
        
    }
    
    func doSearchForUserBeforeSegue()
    {
        var theSession =  NSURLSession.sharedSession()
        var access_token : String = NSUserDefaults.standardUserDefaults().objectForKey(userPrefKeys_accessToken) as! String
        if let url : NSURL = NSURL( string: Instagram_API.getUserSearch(access_token, query_user_name: self.searchBar.text ) )
        {
            theSession.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) -> Void in
                
                let jsonData : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)!
                
                if (jsonData.objectForKey("meta")!.objectForKey("code") as! Int) == 200
                {
                    self.results = [Model_User]()
                    for eachUser in (jsonData.objectForKey("data") as! NSMutableArray)
                    {
                        var firstName = ""
                        if(eachUser.objectForKey("first_name") != nil)
                        {
                            firstName = eachUser.objectForKey("first_name") as! String
                        }
                    
                        var lastName = ""
                        if(eachUser.objectForKey("last_name") != nil)
                        {
                            lastName = eachUser.objectForKey("last_name") as! String
                        }
                    
                        self.results?.append(
                            Model_User(        id: eachUser.objectForKey("id") as! String,
                                                username: eachUser.objectForKey("username") as! String,
                                                profile_picture: eachUser.objectForKey("profile_picture") as! String,
                                                first_name: firstName,
                                                last_name: lastName
                            )
                        )
                    }
            
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.goToSearchNow()
                    
                    return
                })
                
            }).resume()
        }
        
    }

    // -- Search Bar methods
    func searchBarSearchButtonClicked( searchBar: UISearchBar)
    {
        self.doSearchForUserBeforeSegue()
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
    

    
    
    
    func goToSearchNow()
    {
        self.performSegueWithIdentifier( self.goToSearch , sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == goToSearch )
        {
            (segue.destinationViewController as! SearchViewController).searchUser = self.searchBar.text
            
            if let haveResults = self.results
            {
                (segue.destinationViewController as! SearchViewController).results = haveResults
            }
            
        }
    }
    
    
    
}