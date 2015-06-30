//
//  Model_User.swift
//  instalkr
//
//  Created by Yvonne on 26/6/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation

struct MUser
{
 //--
    let id : String
    let username : String
    
    var full_name : String = ""
    var profile_picture : String = ""
 //--
    
    var bio : String = ""
    var website : String = ""
    
    var counts : [String:Int] = [ "media" : 0 , "follows" : 0 , "followed_by" : 0 ]
    
    var position : [String:Int] = [ "x" : 0 , "y" : 0 ]
    
}
