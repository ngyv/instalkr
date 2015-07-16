//
//  ViewModel_UserCell.swift
//  instalkr
//
//  Created by Yvonne Ng on 7/16/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation
import UIKit

class VMCellUser : UITableViewCell
{
    
    @IBOutlet weak var userImg: VMCellImg!
    @IBOutlet weak var usernameLabel: VMCellLabel!
    @IBOutlet weak var fullNameLabel: VMCellLabel!
    
    
    required init(coder aDecoder: NSCoder)
    {
                
        super.init(coder: aDecoder)
    }
    
    func setStyle()
    {
        self.userImg!.setStyle()
        //self.usernameLabel!.setStyle(1)
        //self.fullNameLabel!.setStyle(2)
    }
    
}

class VMCellImg : UIImageView
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
        self.contentMode = UIViewContentMode.ScaleAspectFit
        self.clipsToBounds = true   // otherwise it will spill over
        
        self.layer.cornerRadius = self.frame.size.width * 0.1
        self.layer.masksToBounds = true
    }
    
}

class VMCellLabel : UILabel
{
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    func setStyle( username1fullname2 : Int )
    {
        var setFont : UIFont?
        
        if(username1fullname2 == 1)
        {
            setFont = UIFont(name: "HelveticaNeue-Light", size: 17.0)!
            self.font = setFont
            self.textColor = UIColor.blackColor()
        }
        else if(username1fullname2 == 2)
        {
            setFont = UIFont(name: "HelveticaNeue-Thin", size: 17.0)!
            self.font = setFont
            self.textColor = UIColor.darkGrayColor()
        }
        
    }
    
}