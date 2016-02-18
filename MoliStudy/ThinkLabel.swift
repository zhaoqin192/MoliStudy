//
//  ThinkLabel.swift
//  MoliStudy
//
//  Created by zhaoqin on 11/30/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

import UIKit

class ThinkLabel: NSObject {

    var labelID: String
    var noteArray: [Note]
    var name: String
    
    override init() {
        labelID = String()
        noteArray = []
        name = String()
    }
}
