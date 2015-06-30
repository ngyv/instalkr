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
        return authenticateURL().authenticateURL
    }
    
    

    //---  USER
    
    class func getBasicUserInfo ( access_token : String, user_id : String ) -> String
    {
        var the = userBasicInfo( access_token: access_token, user_id: user_id )
        
        return the.basicUserInfo
    }

    class func getUserFeed ( access_token : String ) -> String
    {
        var the = userFeed(access_token: access_token)
        
        return the.userFeed
    }
    
    class func getRecentMedia ( access_token : String, user_id: String ) -> String
    {
        var the = userRecentMedia( access_token: access_token, user_id: user_id )
        
        return the.recentMedia
        
    }
    
    class func getMediaLiked ( access_token : String ) -> String
    {
        var the = userLikedMedia( access_token: access_token )
        
        return the.mediaLiked
        
    }
    
    class func getUserSearch ( access_token : String, query_user_name: String ) -> String
    {
        var the = userSearch( access_token: access_token, query_user_name: query_user_name )
        
        return the.userSearch
    }
    
    
    
    
    
    //---  MEDIA
    
    class func getMediaInfo ( access_token : String, media_id : String ) -> String
    {
        var the = mediaInfo( access_token: access_token, media_id: media_id )
        
        return the.mediaInfo
    }
    
    class func getMediaGEOSearch (access_token: String, latitude: String, longitude: String) -> String
    {
        var the = mediaGEOSearch(access_token: access_token, latitude: latitude, longitude: longitude)
        
        return the.mediaGEOSearch
    }
    
    class func getMediaPopular ( access_token : String ) -> String
    {
        var the = mediaPopular( access_token: access_token )
        
        return the.mediaPopular
    }

    
    
    
    //---  RELATIONSHIP
    
    class func getRelationshipUserFollows ( access_token : String , user_id : String ) -> String
    {
        var the = relationshipUserFollows( access_token: access_token, user_id: user_id )
        
        return the.relationshipUserFollows
    }
    
    class func getRelationshipUserFollowedBy ( access_token : String , user_id : String ) -> String
    {
        var the = relationshipUserFollowedBy( access_token: access_token, user_id: user_id )
        
        return the.relationshipUserFollowedBy
    }
}



//******************************************************************************************************

//  -----    Authentication    -----

struct authenticateURL
{
    let client_id : String = "89dc0b5019ed496da3ce54763e3b5254"
    
    let redirect_URL : String = "http://sassycodes.tumblr.com"
    
    var authenticateURL : String
    {
        return "https://instagram.com/oauth/authorize/?client_id=\(client_id)&redirect_uri=\(redirect_URL)&response_type=token"
    }
    
}




//______________ USER _______________


struct userBasicInfo {
    
    let access_token : String
    
    let user_id : String
    
    var basicUserInfo : String
    {
        return "https://api.instagram.com/v1/users/\(user_id)/?access_token=\(access_token)"
    }
}

struct userFeed {
    
    let access_token : String
    
    var userFeed : String
    {
        return "https://api.instagram.com/v1/users/self/feed?access_token=\(access_token)"
    }
}


struct userRecentMedia {
    
    let access_token : String
    
    let user_id : String
    
    var recentMedia : String
    {
        return "https://api.instagram.com/v1/users/\(user_id)/media/recent/?access_token=\(access_token)"
    }

}


struct userLikedMedia
{
    let access_token : String
    
    var mediaLiked : String
    {
            return "https://api.instagram.com/v1/users/self/media/liked?access_token=\(access_token)"
    }
}


struct userSearch
{
    let access_token : String
    
    let query_user_name : String
    
    var userSearch : String
    {
        return "https://api.instagram.com/v1/users/search?q=\(query_user_name)&access_token=\(access_token)"
        
    }
}


//______________ MEDIA _______________

struct mediaInfo
{
    let access_token : String
    
    let media_id : String
    
    var mediaInfo : String
    {
        return "https://api.instagram.com/v1/media/\(media_id)?access_token=\(access_token)"
    }
}


struct mediaGEOSearch
{
    let access_token : String
    
    var latitude : String
    var longitude : String
    
    var mediaGEOSearch : String
    {
        return "https://api.instagram.com/v1/media/search?lat=\(latitude)&lng=\(longitude)&access_token=\(access_token)"
    }
    
}


struct mediaPopular
{
    let access_token : String
    
    var mediaPopular : String
    {
        return "https://api.instagram.com/v1/media/popular?access_token=\(access_token)"
    }
}


//______________ RELATIONSHIP _______________


struct relationshipUserFollows
{
    let access_token : String
    
    let user_id : String
    
    var relationshipUserFollows : String
    {
        return "https://api.instagram.com/v1/users/\(user_id)/follows?access_token=\(access_token)"
    }
}

struct relationshipUserFollowedBy
{
    let access_token : String
    
    let user_id : String
    
    var relationshipUserFollowedBy : String
    {
        return "https://api.instagram.com/v1/users/\(user_id)/followed-by?access_token=\(access_token)"
    }
}



















