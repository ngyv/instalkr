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
    
    
    @IBOutlet weak var mainUserNode: VMUser!
    @IBOutlet weak var followsMiddleNode: VMUser!
    @IBOutlet weak var followsLeftNode: VMUser!
    @IBOutlet weak var followsRightNode: VMUser!
    @IBOutlet weak var followedByMiddleNode: VMUser!
    @IBOutlet weak var followedByLeftNode: VMUser!
    @IBOutlet weak var followedByRightNode: VMUser!
    
    
    var theGraph : Graph
    var theAlgorithm : Algorithm?
    
    let swipeUp : UISwipeGestureRecognizer = UISwipeGestureRecognizer()
    
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
        
        self.swipeUp.addTarget(self, action: "swipeAction:")
        
        self.linkUserViews()

        self.reloadUserView(self.theGraph.userInFocus.myself, userView: mainUserNode)
        
        self.getContacts(self.theGraph.userInFocus.myself.id)
        
        
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
            
            allNodes[i].imageView?.addGestureRecognizer( swipeUp )
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
            self.reloadUserView(models![i], userView: nodes![i])
        }
        
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
                    userView.imageView!.image = UIImage(data: data)!
                    
                    UIView.animateWithDuration(1.0, delay: 0.8, options: UIViewAnimationOptions.CurveLinear, animations: {   () -> Void in
                        
                        userView.usernameLabel!.text = user.username
                        userView.usernameLabel!.alpha = 1.0
                        
                        }
                        , completion: {   (done) -> Void in
                            
                            
                    })
                    
                    return
                    
                })
                
                
                
            })
            
            task.resume()
        }
        
        
    }

    func swipeAction( sender: UISwipeGestureRecognizer )
    {
        var theView : UIImageView = sender.view as! UIImageView
        var ind : Int = (theView.tag % 100) - 2
        
        var allContactNodes : [ VMUser ] = [ followsMiddleNode, followsLeftNode, followsRightNode,
                                             followedByMiddleNode, followedByLeftNode, followedByRightNode ]
        
        if( ind < 3 ) //follows
        {
            
            
        }
        else          //followed by
        {
            
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
                
                NSLog("Follows : \n\n\(self.theGraph.userInFocus.myTopContacts[contactsFollows]?.count)\n")
                
     //********
                self.loadUserViews( 1 )
     //********           
                
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
                
                NSLog("Followed By : \n\n\(self.theGraph.userInFocus.myTopContacts[contactsFollowedBy]?.count)\n")
                
                
    //********
                self.loadUserViews( 2 )
    //********
                
                
                
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