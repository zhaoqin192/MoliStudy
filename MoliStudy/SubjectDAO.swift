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
            }
            let answers = model["answers"] as! NSArray
            for j in 0...answers.count - 1{
                let answer = answers[j] as! NSArray
                var detailstr = String()
                for detail in answer{
                    detailstr += detail as! String
                    detailstr += " "
                }
                subject.answers.append(detailstr)
            }
            subject.correctAnswer = model["correct_answer"] as! String
            
            let thinkLabels = model["think_labels"] as! NSArray
            for j in 0...thinkLabels.count - 1{
                let labels = thinkLabels[j] as! NSArray
                let thinkLabel = ThinkLabel()
                for n in 0...labels.count - 1{
                    let label = labels[n] as! NSDictionary
                    if label["think_label_type_id"] as! NSNumber == 0{
                        break
                    }
                    thinkLabel.labelID = String(label["think_label_type_id"] as! NSNumber)
                    thinkLabel.name = label["name"] as! String
                    let note = Note()
                    note.positionStart = label["position_start"] as! NSNumber
                    note.positionEnd = label["position_end"] as! NSNumber
                    note.style = label["style"] as! String
                    note.noteContent = label["note"] as! String
                    if label["is_study"] as! NSNumber == 0{
                        note.isStudied = false
                    }else{
                        note.isStudied = true
                    }
                    thinkLabel.noteArray.append(note)
                }
                subject.thinkLabel.append(thinkLabel)
            }
            subjectsArray.append(subject)
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_SUBJECT_SUCCESS", object: nil) 
    }
    
}