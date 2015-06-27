//
//  Model_Media.swift
//  instalkr
//
//  Created by Yvonne on 26/6/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation



struct MMedia
{
    let link : String
    let id : String
    let created_time : String
    let images : [ String:image ]
    let user : [String:String] = [ "username": "", "profile_picture" : "", "id" : "" ]
    
    var caption : [String:String] = [ "created_time" : "", "text": "", "from.username" : "", "from.id" : "", "id" : "" ]
    var likesCount : Int
    var likesData : [[String:String]] = [ ["username" : "", "full_name" : "", "id" : "", "profile_picture" : "" ] ]
    var tags : [String]
    var users_in_photo : [ MUser ]
    
    struct image {
        var url : String
        var width : Int
        var height : Int
    }
    
}