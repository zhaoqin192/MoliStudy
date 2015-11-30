//
//  PracticeDAO.swift
//  MoliStudy
//
//  Created by zhaoqin on 11/30/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

import UIKit

class PracticeDAO: NSObject {

    static let sharedManager = PracticeDAO()
    var listData = [Practice]()
    
    let managedContext = ContextDAO.sharedInstance.appContext
    
    override init() {
        let fetchRequest = NSFetchRequest(entityName: "Practice")
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            if results.count != 0{
                for practice in results{
                    listData.append(practice as! Practice)
                }
            }
        }catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func save(){
        ContextDAO.sharedInstance.appDelegate.saveContext()
    }
    
    func addPractice(array: NSArray){
        let fetchRequest = NSFetchRequest(entityName: "Practice")
        for i in 0...array.count - 1{
            let object = array[i] as! NSDictionary
            let predicate = NSPredicate(format: "itemID = %@", object["id"] as! String)
            fetchRequest.predicate = predicate
            
            do{
                let results = try managedContext.executeFetchRequest(fetchRequest)
                let practice: Practice!
                print(results.count)
                if results.count != 0{
                    practice = results[0] as! Practice
                }else{
                    practice = NSEntityDescription.insertNewObjectForEntityForName("Practice", inManagedObjectContext: managedContext) as! Practice
                    practice.itemID = Int(object["id"] as! String)
                }
                practice.name = object["name"] as? String
                practice.finished = Int(object["question_studied"] as! String)
                practice.total = Int(object["question_count"] as! String)
                listData.append(practice)
            }catch let error as NSError{
                print("Could not fetch \(error), \(error.userInfo)")
            }
            
        }
        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_TRAIN_SUCCESS", object: nil)
        save()
    }
    
    func findAll() -> [Practice]{
        return listData
    }
}
