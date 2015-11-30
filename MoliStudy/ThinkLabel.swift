//
//  ThinkLabel.swift
//  MoliStudy
//
//  Created by zhaoqin on 11/30/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

import UIKit

class ThinkLabel: NSObject {

    var labelID: NSNumber
    var noteArray: [Note]
    var name: String
    
    override init() {
        labelID = NSNumber()
        noteArray = []
        name = String()
    }
}
