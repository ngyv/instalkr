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

    @IBOutlet weak var mainUserNode: VMUser!
    
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
        
        self.mainUserNode.showView( self.theGraph.userInFocus.myself )
        
        
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