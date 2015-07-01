//
//  Model_User.swift
//  instalkr
//
//  Created by Yvonne on 26/6/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation


class Model_User
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
    
    
    init(id :  String, username : String, full_name : String, profile_picture :  String, bio :  String, website :  String,
        counts : [String : Int], position: [String : Int])
    {
        self.id = id
        self.username = username
        self.full_name = full_name
        self.profile_picture = profile_picture
        self.bio = bio
        self.website = website
        self.counts = counts
        self.position = position
    }
    
    
    convenience init(id :  String, username : String,profile_picture :  String, position: [String : Int])
    {
        self.init(id: id, username: username, full_name: "", profile_picture: profile_picture, bio: "", website: "", counts: [ "media" : 0 , "follows" : 0 , "followed_by" : 0 ], position: position)
    }
    
    convenience init(id: String, username: String, full_name: String, profile_picture: String)
    {
        self.init(id :  id, username : username, full_name : full_name, profile_picture :  profile_picture, bio :  "", website :  "",
            counts : [ "media" : 0 , "follows" : 0 , "followed_by" : 0 ], position: [ "x" : 0 , "y" : 0 ])
    }
    
    convenience init(id : String, username: String, profile_picture : String)
    {
        self.init(id :  id, username : username, full_name : "", profile_picture :  profile_picture, bio :  "", website :  "",
        counts : [ "media" : 0 , "follows" : 0 , "followed_by" : 0 ], position: [ "x" : 0 , "y" : 0 ])
    }
    
    class func createMUser (fromJsonData : AnyObject) -> Model_User
    {
        var counts : [String:Int] = fromJsonData.objectForKey("counts") as! [String:Int]
        

        var userLogged = Model_User(
            
            id : fromJsonData.objectForKey("id") as! String,
            username : fromJsonData.objectForKey("username") as! String,
            full_name : fromJsonData.objectForKey("full_name") as! String,
            profile_picture : fromJsonData.objectForKey("profile_picture") as! String,
            bio : fromJsonData.objectForKey("bio") as! String,
            website : fromJsonData.objectForKey("website") as! String,
            counts : counts,
            
            position : [ "x" : 0 , "y" : 0 ]
            
        )
        
        return userLogged
    }
    
}

