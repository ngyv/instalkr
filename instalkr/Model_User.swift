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
    
    convenience init(id : String, username: String, profile_picture : String, first_name : String, last_name : String)
    {
        self.init(id :  id, username : username, full_name : "\(first_name) \(last_name)", profile_picture :  profile_picture, bio :  "", website :  "", counts : [ "media" : 0 , "follows" : 0 , "followed_by" : 0 ], position: [ "x" : 0 , "y" : 0 ])
    }
    
    
    //______________________________  Create functions  ______________________________
    
    
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
    
    class func createListOfUsers (fromJsonData : [ AnyObject ]) -> [ Model_User ]
    {
        var listOfUsers : [ Model_User ] = [ Model_User ]()
        if( fromJsonData.count > 0)
        {
            // User Follows & Followed_Bys
            if( fromJsonData[0].allKeys.count == 4 )
            {
                for eachUser in fromJsonData
                {
                    listOfUsers.append( Model_User(
                        id: eachUser.objectForKey("id") as! String,
                        username: eachUser.objectForKey("username") as! String,
                        full_name: eachUser.objectForKey("full_name") as! String,
                        profile_picture: eachUser.objectForKey("profile_picture") as! String
                        ))
                }
            }
            else if( fromJsonData[0].allKeys.count == 5 )
            {
                for eachUser in fromJsonData 
                {
                    listOfUsers.append( Model_User(
                        id: eachUser.objectForKey("id") as! String,
                        username: eachUser.objectForKey("username") as! String,
                        profile_picture: eachUser.objectForKey("profile_picture") as! String,
                        first_name: eachUser.objectForKey("first_name") as! String,
                        last_name: eachUser.objectForKey("last_name") as! String
                        ))
                }
            }
        }
        
        return listOfUsers
    }
    
    
    //______________________________  Sort functions  ______________________________
    
    // $0.propertyName > $1.propertyName     for Descending order
    //                 <                     for Ascending order
    
    class func sortMostFollowedByUsers ( inout fromUsersArray : [ Model_User ] )
    {
        fromUsersArray.sort({ $0.counts["followed_by"] > $1.counts["followed_by"] })
    }
    
    class func sortMostFollowsUsers ( inout fromUsersArray : [ Model_User ] )
    {
        fromUsersArray.sort({ $0.counts["follows"] > $1.counts["follows"] })
    }
    
    class func sortMostMediaUsers ( inout fromUsersArray : [ Model_User ] )
    {
        fromUsersArray.sort({ $0.counts["media"] > $1.counts["media"] })
    }
    
    
    
    
}















