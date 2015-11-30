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
        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_SUBJECT_SUCCESS", object: nil)
    }
    
    func addSubjectByID(response: NSArray){
        parseArray(response)
        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_SUBJECTBYID_SUCCESS", object: nil)
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
            subject.questionID = model["question_total_id"] as! NSNumber
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
            
            let thinklabellists = array["thinklabellist"] as! NSArray
            let thinklabellist = thinklabellists[0] as! NSArray
            for j in 0...thinklabellist.count - 1{
                let label = thinklabellist[j] as! NSDictionary
                if Int(label["id"] as! String) == 0{
                    break
                }
                let thinkLabel = ThinkLabel()
                thinkLabel.labelID = Int(label["id"] as! String)!
                thinkLabel.name = label["name"] as! String
                subject.thinkLabel.append(thinkLabel)
            }
            
            let thinklabels = model["think_labels"] as! NSArray
            for j in 0...thinklabels.count - 1{
                let thinks = thinklabels[j] as! NSArray
                for m in 0...thinks.count - 1{
                    let notes = thinks[m] as! NSDictionary
                    let note = Note()
                    note.positionStart = notes["position_start"] as! NSNumber
                    note.positionEnd = notes["position_end"] as! NSNumber
                    note.style = notes["style"] as! String
                    note.noteContent =  UtilityManager.removeHTMLTag(notes["note"] as! String)
                    if notes["is_study"] as! NSNumber == 0{
                        note.isStudied = false
                    }else{
                        note.isStudied = true
                    }
                    for thinkLabelObject in subject.thinkLabel{
                        if thinkLabelObject.labelID == notes["think_label_type_id"] as! NSNumber{
                            thinkLabelObject.noteArray.append(note)
                        }
                    }
                }
            }
            subjectsArray.append(subject)
        }
 
    }
    
}