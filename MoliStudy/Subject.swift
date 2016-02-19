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
    var answers: [String]
    var correctAnswer: String
    var questionID: NSNumber
    var thinkLabel: [ThinkLabel]
    
    
//    var content: [String]{
//        get{
//            return self.content
//        }
//        set(newVal){
//            self.content = newVal
//        }
//    }
//    var answers: [String]{
//        get{
//            return self.answers
//        }set(newVal){
//            self.answers = newVal
//        }
//    }
//    var correctAnswer: String{
//        get{
//            return self.correctAnswer
//        }set(newVal){
//            self.correctAnswer = newVal
//        }
//    }
//    var questionID: NSNumber{
//        get{
//            return self.questionID
//        }set(newVal){
//            self.questionID = newVal
//        }
//    }
//    var thinkLabel: [ThinkLabel]{
//        get{
//            return self.thinkLabel
//        }set(newVal){
//            self.thinkLabel = newVal
//        }
//    }
    
    override init() {
        content = []
        answers = []
        correctAnswer = String()
        questionID = NSNumber()
        thinkLabel = []
    }
    
    
}
