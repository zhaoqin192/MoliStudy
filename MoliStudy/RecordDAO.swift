//
//  RecordDAO.swift
//  MoliStudy
//
//  Created by zhaoqin on 11/30/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

import UIKit

class RecordDAO: NSObject {

    static let sharedManager = RecordDAO()
    let managedContext = ContextDAO.sharedInstance.appContext
    
    var record: Record!
    var isExist = false
    
    override init() {
        
        let fetchRequest = NSFetchRequest(entityName: "Record")
        
        
        do{
            
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            if results.count != 0{
                record = results[0] as! Record
                isExist = true
            }
        }catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func save(){
        ContextDAO.sharedInstance.appDelegate.saveContext()
    }
    
    
    func addRecord(forecast: NSNumber, total: NSNumber, correct: NSNumber){
        if !isExist{
            record = NSEntityDescription.insertNewObjectForEntityForName("Record", inManagedObjectContext: managedContext) as! Record
        }
        record.forecast = forecast
        record.complete = total
        record.accuracy = String(correct.floatValue / total.floatValue)
        
        save()
    }
}
