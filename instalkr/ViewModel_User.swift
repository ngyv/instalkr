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
    var image : UIImageView
    var username : UILabel
    
    
    required override init(frame: CGRect) {
        
        
        self.image = UIImageView()
        self.username = UILabel()
        
        super.init(frame: frame)
        
    }

    required init(coder aDecoder: NSCoder) {
        
        self.image = UIImageView()
        self.username = UILabel()
        
        super.init(coder: aDecoder)
        
    }
    
}