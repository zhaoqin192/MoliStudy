//
//  SubjectDAO.swift
//  MoliStudy
//
//  Created by zhaoqin on 11/30/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

import UIKit

class SubjectDAO: NSObject {

    static let sharedManager = SubjectDAO()
    var subjectsArray: [Subject]
    
    override init() {
        subjectsArray = []
    }
    
    func addSubject(response: NSArray){
        parseArray(response)
    }
    
    func findAll() -> [Subject]{
        return subjectsArray
    }

    
    func parseArray(response: NSArray){
        self.subjectsArray.removeAll()
        
        for i in 0...response.count - 1{
            let array = response[i] as! NSDictionary
            let subject = Subject()
            let modelarray = array["modelarr"] as! NSArray
            let model = modelarray[0] as! NSDictionary
            subject.questionID = model["id"] as! NSNumber
            let contents = model["name"] as! [String]
            for content in contents{
                subject.content.append(content)
                subject.allString.append(content)
            }
            let answers = model["answers"] as! NSArray
            subject.answers = [[String]](count: answers.count, repeatedValue:[])
            for j in 0...answers.count - 1{
                let answer = answers[j] as! NSArray
                for detail in answer{
                    subject.answers[j].append(detail as! String)
                    subject.allString.append(detail as! String)
                }
            }
            subject.correctAnswer = model["correct_answer"] as! String
            
            let thinkLabels = model["think_labels"] as! NSArray
            for j in 0...thinkLabels.count - 1{
                let labels = thinkLabels[j] as! NSArray
                let thinkLabel = ThinkLabel()
                var flag = false
                for n in 0...labels.count - 1{
                    let label = labels[n] as! NSDictionary
                    if label["think_label_type_id"] as! NSNumber == 0{
                        flag = true
                        break
                    }
                    thinkLabel.labelID = String(label["think_label_type_id"] as! NSNumber)
                    thinkLabel.name = label["type_name"] as! String
                    let note = Note()
                    note.positionStart = label["position_start"] as! NSNumber
                    note.positionStart = note.positionStart.integerValue - 1
                    note.positionEnd = label["position_end"] as! NSNumber
                    note.positionEnd = note.positionEnd.integerValue - 1
                    note.style = parseStyle(label["style"] as! String)
                    note.noteContent = label["note"] as! String
                    note.noteContent =  UtilityManager.removeHTMLTag(note.noteContent)
                    if label["is_study"] as! NSNumber == 0{
                        note.isStudied = false
                    }else{
                        note.isStudied = true
                    }
                    thinkLabel.noteArray.append(note)
                }
                if !flag{
                    subject.thinkLabel.append(thinkLabel)
                }
            }
            subjectsArray.append(subject)
        }
        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_SUBJECT_SUCCESS", object: nil) 
    }
    
    func parseStyle(style: String) ->String{
        let array = style.componentsSeparatedByString(",")
        var result: String = ""
        for str in array{
            if str == "bg_red"{
                result = Tinty.bg_red
            }else if str == "bg_blue"{
                result = Tinty.bg_blue
            }else if str == "bg_green"{
                result = Tinty.bg_green
            }else if str == "bg_yellow"{
                result = Tinty.bg_yellow
            }else if str == "bg_orange"{
                result = Tinty.bg_orange
            }else if str == "bg_purple"{
                result = Tinty.bg_purple
            }else if str == "bg_gray"{
                result = Tinty.bg_gray
            }else{
            }
        }
        return result
    }
    
}