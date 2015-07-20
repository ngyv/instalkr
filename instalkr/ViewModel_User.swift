//
//  ViewModel_User.swift
//  instalkr
//
//  Created by Yvonne Ng on 7/2/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation
import UIKit

class VMUser : UIView
{
    var selected : Int = 0
    var translation :  CGPoint?
    var imageView : VMImg?
    var usernameLabel : VMLabel?
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect)
    {
       super.init(frame: frame)
        
        
    }
    
    func setStyle()
    {
        self.layer.cornerRadius = self.frame.size.width * 0.1
        self.layer.borderColor = UIColor.lightTextColor().CGColor
        self.layer.borderWidth = 0.3
        
        self.imageView?.setStyle()
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
    }
    
}

class VMImg : UIImageView
{
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    func setStyle()
    {
        self.layer.cornerRadius = self.frame.size.width * 0.45
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.borderWidth = 0.7
        
        self.userInteractionEnabled = true
    }
    
}

class VMLabel : UILabel
{
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    

    
}