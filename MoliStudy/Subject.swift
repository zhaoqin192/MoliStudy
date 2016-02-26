//
//  Subject.swift
//  MoliStudy
//
//  Created by zhaoqin on 11/30/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

import UIKit

class Subject: NSObject {

    var content: [String]
    var answers: [[String]]
    var correctAnswer: NSInteger
    var questionID: NSNumber
    var thinkLabel: [ThinkLabel]
    var allString: [String]
    
    override init() {
        content = []
        answers = []
        correctAnswer = -1
        questionID = NSNumber()
        thinkLabel = []
        allString = []
    }
    
    
}
