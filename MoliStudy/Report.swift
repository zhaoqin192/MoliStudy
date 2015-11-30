//
//  Report.swift
//  MoliStudy
//
//  Created by zhaoqin on 11/30/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

import UIKit

class Report: NSObject {

    var knowledgeID: NSNumber
    var score: NSNumber
    var variety: NSNumber
    var name: String
    
    override init() {
        knowledgeID = NSNumber()
        score = NSNumber()
        variety = NSNumber()
        name = String()
    }
    
}
