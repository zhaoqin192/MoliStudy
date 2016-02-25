//
//  Label.swift
//  MoliStudy
//
//  Created by zhaoqin on 2/23/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

import Foundation

class Label: NSObject{
    
    var label: UILabel
    var positionEnd: NSNumber
    
    override init(){
        label = UILabel.init();
        positionEnd = NSNumber();
    }
}
