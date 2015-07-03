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
    var imageView : UIImageView?
    var usernameLabel : UILabel?
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect)
    {
       super.init(frame: frame)
    }
}