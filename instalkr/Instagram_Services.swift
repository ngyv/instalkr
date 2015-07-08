//
//  Instagram_Services.swift
//  instalkr
//
//  Created by Yvonne Ng on 6/30/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation

class Instagram_Services
{
    var theSession : NSURLSession = NSURLSession.sharedSession()
    var access_token : String
    
    init( access_token : String )
    {
        self.access_token = access_token
    }
    
    // -------------------  Loading into Models  ---------------------
    
    func populateUserData ( user_id : String ) -> Model_User
    {
        var theUser : Model_User?
        
        if let url : NSURL = NSURL( string: Instagram_API.getBasicUserInfo(access_token, user_id: user_id) )
        {
            theSession.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) -> Void in
                
                let jsonData : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers , error: nil)!
                
                theUser = Model_User.createMUser(jsonData.objectForKey("data")!)
                
                
            }).resume()
        }
        
        return theUser!
    }
    
    func populateMoreUserInfo ( inout user : Model_User )
    {
        user = populateUserData(user.id)
    }
    
    
    func populateUsersRecentMedia ( user_id : String, numOfMedia : String ) -> [ Model_Media ]
    {
        var recentMedia : [ Model_Media ] = [ Model_Media ]()
        
        if let url : NSURL = NSURL( string: Instagram_API.getRecentMedia(access_token, user_id: user_id, mediaCount : numOfMedia) )
        {
            theSession.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) -> Void in
                
                let jsonData : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers , error: nil)!
                
                for eachItem in (jsonData.objectForKey("data") as! [AnyObject])
                {
                    recentMedia.append(Model_Media.createMMedia(eachItem))
                }
            }).resume()
        }
        
        return recentMedia
    }
    
    /*
    ________________ Needs work
    
    
    
    
    func populateUsersFollows ( user_id : String ) -> [ Model_User ]?
    {
        var userFollows : [ Model_User ]?
        
        if let url : NSURL = NSURL ( string: Instagram_API.getRelationshipUserFollows(access_token, user_id: user_id) )
        {
            
            theSession.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) -> Void in
                
                let jsonData : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)!
                
                userFollows = Model_User.createListOfUsers( jsonData.objectForKey("data") as! [AnyObject])
                
          
                
            }).resume()

            
        }
        
        
        return userFollows
    }
    
    
    func populateUsersFollowedBy ( user_id : String ) -> [ Model_User ]
    {
        var usersFollowedBy : [ Model_User ] = [ Model_User ]()
        
        if let url : NSURL = NSURL ( string: Instagram_API.getRelationshipUserFollowedBy(access_token, user_id: user_id) )
        {
            theSession.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) -> Void in
                
                let jsonData : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)!
                
                
                usersFollowedBy = Model_User.createListOfUsers(jsonData.objectForKey("data")! as! [AnyObject])
                
                
            }).resume()
            
        }
        
        
        return usersFollowedBy
    }
    
    func populateUserSearch ( queryUsername : String ) -> [ Model_User ]
    {
        var userResults : [ Model_User ] = [ Model_User ]()
        
        if let url : NSURL = NSURL(string: Instagram_API.getUserSearch(access_token, query_user_name: queryUsername) )
        {
            theSession.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) -> Void in
                
                let jsonData : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)!
                
                userResults = Model_User.createListOfUsers(jsonData.objectForKey("data")! as! [AnyObject])
            }).resume()
            
        }
        
        return userResults
    }
    
    
    */
    
    //___________________ Loading into Views ___________________
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}