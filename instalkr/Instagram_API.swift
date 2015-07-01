//
//  Instagram_API.swift
//  instalkr
//
//  Created by Yvonne Ng on 6/30/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation


class Instagram_API
{
    
    class func getAuthenticateURL() -> String
    {
        let client_id : String = "89dc0b5019ed496da3ce54763e3b5254"
        
        let redirect_URL : String = "http://sassycodes.tumblr.com"
        
        return "https://instagram.com/oauth/authorize/?client_id=\(client_id)&redirect_uri=\(redirect_URL)&response_type=token"
    }
    
    

    //---  USER
    
    class func getBasicUserInfo ( access_token : String, user_id : String ) -> String
    {
        return "https://api.instagram.com/v1/users/\(user_id)/?access_token=\(access_token)"
    }
    
    class func getOWNBasicUserInfo ( access_token : String ) -> String
    {
        return getBasicUserInfo(access_token, user_id: "self")
    }
    

    class func getUserFeed ( access_token : String ) -> String
    {
        return "https://api.instagram.com/v1/users/self/feed?access_token=\(access_token)"
    }
    
    class func getRecentMedia ( access_token : String, user_id: String, mediaCount : String ) -> String
    {
        return "https://api.instagram.com/v1/users/\(user_id)/media/recent/?access_token=\(access_token)&count=\(mediaCount)"
    }
    
    class func getOWNRecentMedia ( access_token : String, user_id: String , mediaCount : String  ) -> String
    {
        return getRecentMedia(access_token, user_id: "self", mediaCount : mediaCount)
    }
    
    
    class func getMediaLiked ( access_token : String ) -> String
    {
        return "https://api.instagram.com/v1/users/self/media/liked?access_token=\(access_token)"
    }
    
    
    class func getUserSearch ( access_token : String, query_user_name: String ) -> String
    {
        return "https://api.instagram.com/v1/users/search?q=\(query_user_name)&access_token=\(access_token)"
    }
    

    
    
    
    //---  MEDIA
    
    class func getMediaInfo ( access_token : String, media_id : String ) -> String
    {
        return "https://api.instagram.com/v1/media/\(media_id)?access_token=\(access_token)"
    }
    
    class func getMediaGEOSearch (access_token: String, latitude: String, longitude: String) -> String
    {
        return "https://api.instagram.com/v1/media/search?lat=\(latitude)&lng=\(longitude)&access_token=\(access_token)"
    }
    
    class func getMediaPopular ( access_token : String ) -> String
    {
        return "https://api.instagram.com/v1/media/popular?access_token=\(access_token)"
    }

    
    
    
    //---  RELATIONSHIP
    
    class func getRelationshipUserFollows ( access_token : String , user_id : String ) -> String
    {
        return "https://api.instagram.com/v1/users/\(user_id)/follows?access_token=\(access_token)"
    }
    
    class func getRelationshipUserFollowedBy ( access_token : String , user_id : String ) -> String
    {
        return "https://api.instagram.com/v1/users/\(user_id)/followed-by?access_token=\(access_token)"
    }
    
    
    
    
    
    //______________________________________________________________________________________________________________
    
    
    
    
    
    
    
    
    
    
    
    
}



















