//
//  Graph.swift
//  instalkr
//
//  Created by Yvonne Ng on 7/1/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation

let contactsFollows : String = "follows"
let contactsFollowedBy : String = "followedBy"

class UserNode
{
    
    // neighbours
    var myTopContacts : [String : [ Model_User ]] = [ String : [ Model_User ]]()
    
    var myself : Model_User
    
    init( me : Model_User, topContacts : [String : [ Model_User ]] )
    {
        self.myself = me
        self.myTopContacts = topContacts
    }
    
    
//*** may want to alter this later
    convenience init ( me : Model_User )
    {
        self.init( me : me, topContacts : [ contactsFollows : [Model_User](), contactsFollowedBy : [Model_User]() ] )
    }
}


class Graph
{
    
    var listOfUserNodes : [ UserNode ] = [ UserNode ]()
    
    var userInFocus : UserNode
    
    // to get the subgraph in focus
    var degreeOfSeparationInFocus : Int = 3
    
    init( allUsers : [ UserNode ] , theMainUser : UserNode , theDegreeOfSeparation : Int )
    {
        self.listOfUserNodes = allUsers
        self.userInFocus = theMainUser
        self.degreeOfSeparationInFocus = theDegreeOfSeparation
    }
    
    
    convenience init( theMainUser : UserNode )
    {
        var all_users : [ UserNode ] = [ theMainUser ]
        
        for contacts in theMainUser.myTopContacts[contactsFollows]!
        {
            all_users.append( UserNode(me: contacts) )
        }
        
        for contacts in theMainUser.myTopContacts[contactsFollowedBy]!
        {
            all_users.append( UserNode(me: contacts) )
        }
        
        self.init( allUsers: all_users, theMainUser: theMainUser, theDegreeOfSeparation: 3)
    }

    
    
    
    
    func swapUserNode ( user : UserNode )
    {
        for var i = 0; i < self.listOfUserNodes.count; i++
        {
            if self.listOfUserNodes[i].myself.id == user.myself.id
            {
                self.listOfUserNodes[i] = user
            }
        }
    }
    
    
}