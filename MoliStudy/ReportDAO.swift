//
//  ReportDAO.swift
//  MoliStudy
//
//  Created by zhaoqin on 11/30/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

import UIKit

class ReportDAO: NSObject {

    static let sharedManager = ReportDAO()
    var reportArray: [Report]
    
    override init() {
        reportArray = []
    }
    
    func findAll() -> [Report]{
        return reportArray
    }
    
    func addArray(array: NSArray){
        reportArray.removeAll()
        
        for i in 0...array.count - 1{
            let reportDic = array[i] as! NSDictionary
            let report = Report()
            report.name = reportDic["name"] as! String
            report.knowledgeID = Int(reportDic["id"] as! String)!
            report.score = reportDic["cur_score"] as! NSNumber
            report.variety = reportDic["change"] as! NSNumber
            reportArray.append(report)
        }
        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_REPORT_SUCCESS", object: nil)
    }
}
