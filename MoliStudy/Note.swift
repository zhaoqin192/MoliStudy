//
//  Note.swift
//  MoliStudy
//
//  Created by zhaoqin on 11/30/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

import UIKit

class Note: NSObject {
    
    var positionStart: NSNumber
    var positionEnd: NSNumber
    var style: String
    var noteContent: String
    var isStudied: Bool
    
    override init() {
        positionStart = NSNumber()
        positionEnd = NSNumber()
        style = String()
        noteContent = String()
        isStudied = false
    }

}
