//
//  Algorithm.swift
//  instalkr
//
//  Created by Yvonne Ng on 7/1/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation

protocol Algorithm
{
    var theGraph : Graph { get set }
    
    mutating func getUserTopContacts( userSelected : Model_User )
    
    
}


/*----------

→  Show {relationship graph}

Show main user profile picture in the middle of the screen
the top 8 people he has tagged in his pictures should be displayed on a ring

(a) if he doesn’t have any pictures, then show 8 people he follows that have the most pictures
(b) if he is not following anyone, then show 8 people that have the most pictures follows him
if he has insufficient contacts (< 8), then combine the pool of people (a) &

*/

class Algorithm_PopularContacts : Algorithm
{
    var theGraph : Graph
    
    init( someGraph : Graph )
    {
        self.theGraph = someGraph
    }
    
    convenience init()
    {
        var userPref : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var userLoggedIn : Model_User = Model_User.createMUser( userPref.objectForKey(userPrefKeys_user)! )
        self.init( someGraph: Graph(theMainUser: UserNode(me: userLoggedIn) ) )
    }
    
    func getUserTopContacts(userSelected: Model_User)
    {
        // mutual follows > popular contacts user follow
        
        
        
        
        
    }
}



