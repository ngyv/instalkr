//
//  ViewModel_User.swift
//  instalkr
//
//  Created by Yvonne on 26/6/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation
import UIKit

class VMUser : UIView
{
    var imageView : UIImageView
    var usernameLabel : UILabel
    
    
    required override init(frame: CGRect)
    {
        
        self.imageView = UIImageView(frame: CGRectMake(10, 179, 180, 21))
        self.usernameLabel = UILabel(frame: CGRectMake(10, 0, 180, 180))
        
        super.init(frame: frame)
        
        
        self.addSubview(self.imageView)
        self.addSubview(self.usernameLabel)
        
        
    }

    required init(coder aDecoder: NSCoder)
    {
        
        self.imageView = UIImageView(coder: aDecoder)
        self.usernameLabel = UILabel(coder: aDecoder)
        
        super.init(coder: aDecoder)
        
        
        self.addSubview(self.imageView)
        self.addSubview(self.usernameLabel)
        
    }
    
    
    func showView( user : Model_User )
    {
        
        
        self.imageView.layer.cornerRadius = 5.0
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.borderColor = UIColor.blueColor().CGColor
        self.imageView.layer.borderWidth = 1.0
        
        self.usernameLabel.font = UIFont(name: "Helvetica Neue", size: 16.0)
        self.usernameLabel.textAlignment = NSTextAlignment.Center
        self.usernameLabel.textColor = UIColor.darkGrayColor()
        var theSession = NSURLSession.sharedSession()

        // Show username first
        self.usernameLabel.text = user.username
        
        // Get Image
/*
        if let url = NSURL( string: user.profile_picture )
        {
            theSession.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) -> Void in
                
                self.imageView.image = UIImage(data: data)!
                
            }).resume()
        }
*/
        
        /*
        [session downloadTaskWithURL:[NSURL URLWithString:imageUrl]
        
        completionHandler:^(NSURL *location,
        NSURLResponse *response,
        NSError *error) {
        // 2
        UIImage *downloadedImage =
        [UIImage imageWithData:
        [NSData dataWithContentsOfURL:location]];
        //3
        dispatch_async(dispatch_get_main_queue(), ^{
        // do stuff with image
        _imageWithBlock.image = downloadedImage;
        });
        }];
        */
        
        
        if let url = NSURL( string: user.profile_picture )
        {
            theSession.downloadTaskWithURL(url, completionHandler: {
                
                (location, response, error) -> Void in
                
                var downloadedImg : UIImage = UIImage(data: NSData(contentsOfURL: location)!)!
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.imageView.image = downloadedImg
                })
            })
        }
        
        
        
        
        

    }
}