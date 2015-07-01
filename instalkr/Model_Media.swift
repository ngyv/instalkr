//
//  Model_Media.swift
//  instalkr
//
//  Created by Yvonne on 26/6/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation

class Model_Media
{
    //--
    let link : String
    let id : String
    let created_time : String
    let images : [ String:Image ] // keys : "standard_resolution" , "low_resolution" , "thumbnail"
    let user : Model_User
    //--
    
    var caption : [String:String] = [ "created_time" : "", "text": "", "from.username" : "", "from.id" : "", "id" : "" ]
    var likesCount : Int
    var likesData : [ Model_User ]
    var tags : [String]
    var users_in_photo : [ Model_User ]
    
    struct Image {
        var url : String
        var width : Int
        var height : Int
    }
    
    init( mediaLink : String, mediaId : String, mediaCreated : String, mediaImages : [ String : Image ], mediaUser : Model_User, mediaCaption : [ String : String], mediaLikesCount : Int, mediaLikesData : [ Model_User ], mediaTags : [ String ], mediaUsersInside : [ Model_User ] )
    {
        self.link = mediaLink
        self.id = mediaId
        self.created_time = mediaCreated
        self.images = mediaImages
        self.user = mediaUser
        self.caption = mediaCaption
        self.likesCount = mediaLikesCount
        self.likesData = mediaLikesData
        self.tags = mediaTags
        self.users_in_photo = mediaUsersInside
    }
    
    class func createMMedia (fromDataDict : AnyObject) -> Model_Media
    {
        var standard_image : AnyObject = fromDataDict.objectForKey("images")!.objectForKey("standard_resolution")!
        var _image : [ String:Image ] = [
            
            "standard_resolution" : Image(url: standard_image.objectForKey("url") as! String, width: standard_image.objectForKey("width") as! Int, height: standard_image.objectForKey("height") as! Int)   ,

            "low_resolution" : Image(url: standard_image.objectForKey("url") as! String, width: standard_image.objectForKey("width") as! Int, height: standard_image.objectForKey("height") as! Int)   ,
            
            "thumbnail" : Image(url: standard_image.objectForKey("url") as! String, width: standard_image.objectForKey("width") as! Int, height: standard_image.objectForKey("height") as! Int)
        ]
  
        var decap : AnyObject = fromDataDict.objectForKey("caption")!
        var _caption : [String : String] =  [
            "created_time" : decap.objectForKey("created_time") as! String,
            "text": decap.objectForKey("text") as! String,
            "from.username" : decap.objectForKey("from")!.objectForKey("username") as! String,
            "from.id" : decap.objectForKey("from")!.objectForKey("id") as! String,
            "id" : decap.objectForKey("id") as! String ]
        

        
        var _likesData : [ Model_User ] = [ Model_User ]()

        var thatLiked : [ AnyObject ] = fromDataDict.objectForKey("likes")!.objectForKey("data") as! [AnyObject]
        for user in thatLiked
        {
            var userThatLiked : Model_User = Model_User(
                id: user.objectForKey("id") as! String,
                username: user.objectForKey("username") as! String,
                full_name: user.objectForKey("full_name") as! String,
                profile_picture: user.objectForKey("profile_picture") as! String
            )
            _likesData.append(userThatLiked)
        }
        
        
        var photo : [ AnyObject ] = fromDataDict.objectForKey("users_in_photo") as! [ AnyObject ]
        var _usersInPhoto : [ Model_User ] = [ Model_User ]()
        
        for user in photo
        {
            var deuser : AnyObject = user.objectForKey("user")!
            var taggedUser : Model_User = Model_User(
                id: deuser.objectForKey("id") as! String,
                username: deuser.objectForKey("username") as! String,
                profile_picture: deuser.objectForKey("profile_picture") as! String,
                position: [ "x" : user.objectForKey("position")!.objectForKey("x") as! Int,
                    "y" : user.objectForKey("position")!.objectForKey("y") as! Int ]
            )
            _usersInPhoto.append(taggedUser)
        }
        
        
        
        var _link : String = fromDataDict.objectForKey("link") as! String
        
        var _id : String = fromDataDict.objectForKey("id") as! String
        
        var _createdTime : String = fromDataDict.objectForKey("created_time") as! String
    
        var deuser : AnyObject = fromDataDict.objectForKey("user")!
        
        var _user : Model_User = Model_User(
            id: decap.objectForKey("id") as! String,
            username: decap.objectForKey("username") as! String,
            profile_picture: decap.objectForKey("profile_picture") as! String
        )
        
        var _likesCount : Int = fromDataDict.objectForKey("likes")!.objectForKey("count") as! Int
        
        var _tags : [ String ] = fromDataDict.objectForKey("tags") as! [ String ]
        
        var theMedia : Model_Media = Model_Media(   mediaLink: _link, mediaId: _id, mediaCreated: _createdTime,
                                                    mediaImages: _image, mediaUser: _user, mediaCaption: _caption,
                                                    mediaLikesCount: _likesCount, mediaLikesData: _likesData,
                                                    mediaTags: _tags, mediaUsersInside: _usersInPhoto)
        
        return theMedia
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
}
