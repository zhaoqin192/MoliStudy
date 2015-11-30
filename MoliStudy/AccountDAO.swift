//
//  AccountDAO.swift
//  MoliStudy
//
//  Created by zhaoqin on 11/30/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

import UIKit

class AccountDAO: NSObject {
    
    static let sharedManager = AccountDAO()
    var isExist = false
    
    var account: Account!
    
    let managedContext = ContextDAO.sharedInstance.appContext
    
    override init() {
        //Create a net fetch request using the Account entity
        let fetchRequest = NSFetchRequest(entityName: "Account")
        
        do{
            
            let results = try managedContext.executeFetchRequest(fetchRequest)

            if results.count != 0{
                self.account = results[0] as! Account
                isExist = true
            }
            print(results.count)
            print(isExist)
        }catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
            
        }
    }
    
    func addAccount(accountName: String, password: String, userID: String){
        if !isExist{
            print("isExist")
            account = NSEntityDescription.insertNewObjectForEntityForName("Account", inManagedObjectContext: managedContext) as! Account
        }
        account.accountName = accountName
        account.password = password
        account.userID = userID
        save()
    }
    
    func completeInfo(userName: String, currentSchool: String, targetSchool: String){
        account.userName = userName
        account.currentAcademy = currentSchool
        account.targetAcademy = targetSchool
        save()
    }
    
    func save(){
        ContextDAO.sharedInstance.appDelegate.saveContext()
    }
    
    func findAccount() -> Account{
        return self.account
    }
}
