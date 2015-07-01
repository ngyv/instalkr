//
//  Graph.swift
//  instalkr
//
//  Created by Yvonne Ng on 7/1/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation

class UserNode
{
    // neighbours
    var myTopContacts : [ Model_User ] = [ Model_User ]()
    
    var myself : Model_User
    
    init( me : Model_User, topContacts : [ Model_User ] )
    {
        self.myself = me
        self.myTopContacts = topContacts
    }

//*** may want to alter this later
    convenience init ( me : Model_User )
    {
        self.init( me : me, topContacts : [Model_User]() )
    }
}


class Graph
{
    var listOfUserNodes : [ String : Model_User ] = [ String : Model_User ]()
    
    var userInFocus : UserNode
    
    // to get the subgraph in focus
    var degreeOfSeparationInFocus : Int = 3
    
    init( allUsers : [ String : Model_User ] , theMainUser : UserNode , theDegreeOfSeparation : Int )
    {
        self.listOfUserNodes = allUsers
        self.userInFocus = theMainUser
        self.degreeOfSeparationInFocus = theDegreeOfSeparation
    }
    
    
    convenience init( theMainUser : UserNode )
    {
        var all_users : [ String : Model_User ] = [ theMainUser.myself.id : theMainUser.myself ]
        
        for contacts in theMainUser.myTopContacts
        {
            all_users[ contacts.id ] = contacts
        }
        
        self.init( allUsers: all_users, theMainUser: theMainUser, theDegreeOfSeparation: 3)
    }

    
}