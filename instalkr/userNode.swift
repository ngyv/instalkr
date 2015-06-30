//
//  userNode.swift
//  instalkr
//
//  Created by Yvonne Ng on 6/30/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation

class userNode
{
    var myTopContacts : [Model_User] = [Model_User]()
    
    var myself : Model_User
    
    init(me : Model_User, topContacts : [Model_User])
    {
        self.myself = me
        self.myTopContacts = topContacts
    }
    
}